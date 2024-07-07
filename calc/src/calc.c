#include <stdio.h>
#include <stdlib.h>
#include "cJSON.h"
#include "calc.h"
#include "common_define.h"

static cJSON *g_dcb_root = NULL;



int calc_init()
{
    LOG_INFO(LOG_SYSTEM,"hello this is calc_init\n");
    return 0;
}

