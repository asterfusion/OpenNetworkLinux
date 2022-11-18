from onl.platform.base import *
from onl.platform.asterfusion import *
import os

class OnlPlatform_x86_64_asterfusion_x308p_r0(OnlPlatformAsterfusion):
    PLATFORM='x86-64-asterfusion-x308p-r0'
    MODEL="x308p"
    SYS_OBJECT_ID=".8.1"
    
    def baseconfig(self):
                
        
        ########### initialize I2C bus 1 ###########
                   
        # initialize i2c

        return True
        
        
