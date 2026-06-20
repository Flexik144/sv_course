`timescale 1ns/1ps

module tb_spi_receiver;

    localparam INPUT_W = 8;
    localparam OUTPUT_W = 48;
    localparam DELAY = OUTPUT_W / INPUT_W;
    localparam NUM_ITER = 5; // Количество тестов

    logic                clk;
    logic                rstn;
    logic                sck;
    logic                ssn;
    logic [INPUT_W-1:0]  mosi;
    
    logic [OUTPUT_W-1:0] out_data;
    logic                out_valid;

    // Внутренние переменные тестбенча
    logic [OUTPUT_W-1:0] ethalon_data [NUM_ITER];
    // ЭТА ПЕРЕМЕННАЯ НУЖНА ДЛЯ ОТОБРАЖЕНИЯ НА ГРАФИКЕ:
    logic [OUTPUT_W-1:0] current_ethalon; 
    
    logic [31:0]         rand1, rand2;
    int                  error_counter = 0;

    // Подключение тестируемого модуля (DUT)
    spi_receiver_top #(
        .INPUT_W(INPUT_W),
        .OUTPUT_W(OUTPUT_W)
    ) dut (
        .i_clk   (clk),
        .i_rstn  (rstn),
        .i_sck   (sck),
        .i_ssn   (ssn),
        .i_mosi  (mosi),
        .o_data  (out_data),
        .o_valid (out_valid)
    );

    // Генерация системного тактового сигнала 240 МГц
    initial begin
        clk = 1'b0;
        forever #2.083 clk = ~clk;
    end

    // Предварительный сброс активным нулем
    initial begin
        rstn <= 1'b0; 
        repeat (10) @(posedge clk);
        rstn <= 1'b1;
    end

    // Процесс стимуляции (Генерация данных)
    initial begin
        sck = 1'b0; 
        ssn = 1'b1;
        mosi = '0;
        current_ethalon = '0; // Инициализация

        @(posedge rstn);
        repeat (10) @(posedge clk);

        $display("STARTING TESTS...");

        // Одиночный режим: передача с паузами
        for (int i = 0; i < NUM_ITER; i++) begin
            rand1 = $urandom;
            rand2 = $urandom;
            ethalon_data[i] = {rand1[15:0], rand2};
            
            // Записываем текущий эталон в сигнал, который увидит ModelSim
            current_ethalon = ethalon_data[i];

            // Начало транзакции
            @(posedge clk);
            ssn = 1'b0;
            
            // Передача данных по SCK
            for (int k = DELAY - 1; k >= 0; k--) begin
                // 1. Выставляем данные
                mosi = ethalon_data[i][(k+1)*INPUT_W-1 -: INPUT_W];
                
                // 2. Генерация фронтов для SPI Mode 1
                #16.6 sck = 1'b1; // Передний фронт (мастер выставил данные)
                #33.3 sck = 1'b0; // Задний фронт (приемник делает захват)
                #16.6;            // Время удержания
            end
            
            // Даем приемнику несколько тактов clk для обработки последнего спада SCK
            repeat (5) @(posedge clk);
            ssn = 1'b1;
            
            // Пауза 100 тактов между посылками
            repeat (100) @(posedge clk); 
        end
    end

    // Процесс проверки (Мониторинг выходов)
    initial begin
        for (int i = 0; i < NUM_ITER; i++) begin
            @(posedge out_valid);
            
            $display("--------------------------------------");
            $display("Test #%0d", i);
            $display("LOADED ETHALON : 48'h%0h", ethalon_data[i]);
            $display("RECEIVED DATA  : 48'h%0h", out_data);

            if (out_data !== ethalon_data[i]) begin
                error_counter++;
                $display(">>> ERROR DETECTED <<<");
            end else begin
                $display(">>> SUCCESS <<<");
            end
        end

        $display("======================================");
        if (error_counter > 0) begin
            $display("TEST FAILED with %0d errors", error_counter);
        end else begin
            $display("ALL TESTS PASSED SUCCESSFULLY");
        end
        $stop;
    end

endmodule