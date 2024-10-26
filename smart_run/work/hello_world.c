/*Copyright 2019-2021 T-Head Semiconductor Co., Ltd.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

// #include "stdio.h"

// int main (void)
// {

// //Section 1: Hello World!
//   printf("\nHello Friend!\n");
//   printf("Welcome to T-HEAD World!\n");

// //Section 2: Embeded ASM in C 
//   int a;
//   int b;
//   int c;
//   a=1;
//   b=2;
//   c=0;
//   printf("\na is %d!\n",a);
//   printf("b is %d!\n",b);
//   printf("c is %d!\n",c);

// asm(
//     "mv  x5,%[a]\n"
//     "mv  x6,%[b]\n"
//     "label_add:"
//     "add  %[c],x5,x6\n"
//     :[c]"=r"(c)
//     :[a]"r"(a),[b]"r"(b)
//     :"x5","x6"
//     );

// if(c == 3)
//   printf("!!! PASS !!!");
// else
//   printf("!!! FAIL !!!");
//   printf("after ASM c is changed to %d!\n",c);

// // while(1){
// //   printf("Hello World!\n");
// // }

//   return 0;
// }


#include "uart.h"
#include "stdio.h"

int main() {
    t_ck_uart_device uart_device;
    t_ck_uart_cfig uart_config;

    // 配置 UART 参数
    uart_config.baudrate = 19200;
    uart_config.stopbit = STOPBIT_1;
    uart_config.parity = PARITY_NONE;
    uart_config.wordsize = WORDSIZE_8;
    uart_config.rxmode = ENABLE;
    uart_config.txmode = ENABLE;

    printf("Ready to open uart\n");

    // 打开 UART 设备
    if (ck_uart_open(&uart_device, 0) != 0) {
        printf("Failed to open UART device\n");
        return 1;
    } else {
        printf("UART device opened\n");
    }

    // 初始化 UART 配置
    if (ck_uart_init(&uart_device, &uart_config) != 0) {
        printf("Failed to initialize UART device\n");
        return 1;
    } else {
        printf("UART device initialized\n");
    }

    // 发送数据
    char data[] = "Hello, UART!";
    while(1){
        for (int i = 0; data[i] != '\0'; i++) {
            if (ck_uart_putc(&uart_device, data[i]) != 0) {
                printf("Failed to send data\n");
                return 1;
            } else {
                printf("Data sent: %c\n", data[i]);
            }
        }
    }

    // 打印 UART 状态
    int status = ck_uart_status(&uart_device);
    if (status == 0) {
        printf("UART is idle\n");
    } else {
        printf("UART is busy\n");
    }

    // 关闭 UART 设备
    if (ck_uart_close(&uart_device) != 0) {
        printf("Failed to close UART device\n");
        return 1;
    } else {
        printf("UART device closed\n");
    }

    return 0;
}