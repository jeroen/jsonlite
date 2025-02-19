/* vi: set ft=c expandtab shiftwidth=4 tabstop=4: */
#ifndef MODP_STDINT_H_
#define MODP_STDINT_H_

/**
 * \file modp_stdint.h
 * \brief An attempt to make stringencoders compile under windows
 *
 * This attempts to define various integral types that are normally
 * defined in stdint.h and stdbool.h which oddly don't exit on
 * windows.
 *
 * Please file bugs or patches if it doesn't work!
 */

#include <string.h>

#include <stdint.h>
#include <stdbool.h>

#endif /* MODP_STDINT_H_ */
