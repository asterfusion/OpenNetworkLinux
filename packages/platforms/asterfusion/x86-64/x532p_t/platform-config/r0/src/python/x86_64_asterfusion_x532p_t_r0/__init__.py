from onl.platform.base import *
from onl.platform.asterfusion import *
import os

class OnlPlatform_x86_64_asterfusion_x532p_t_r0(OnlPlatformAsterfusion):
    PLATFORM='x86-64-asterfusion-x532p-t-r0'
    MODEL="x532p_t"
    SYS_OBJECT_ID=".8.1"
    
    def baseconfig(self):
                
        
        ########### initialize I2C bus 1 ###########
                   
        # initialize i2c

        return True
        
        
