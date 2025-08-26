#include <libopencm3/stm32/rcc.h>
#include <libopencm3/stm32/gpio.h>


static void rcc_setup(void) {
  rcc_clock_setup_pll(&rcc_hsi_configs[RCC_CLOCK_3V3_84MHZ]);
}

static void gpio_setup(void) {
  rcc_periph_clock_enable(RCC_GPIOA);
  gpio_mode_setup(GPIOC, GPIO_MODE_OUTPUT, GPIO_PUPD_NONE, GPIO13);
}

static void delay_cycles(uint32_t cycles) {
  for (uint32_t i = 0; i < cycles; i++) {
    __asm__("nop");
  }
}

int main(void) {
  rcc_setup();
  gpio_setup();

  while (1) {
    gpio_toggle(GPIOC, GPIO13);
    delay_cycles(84000000 / 4);
  }

  // Never return
  return 0;
}