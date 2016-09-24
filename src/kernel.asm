








// section for kernel call (interapts) this will be called

inter:
  pusha
  cmp eax,4 ; if it has the value 4 then it will do a sys_out 
  je print
  
  
print:
  mov al,bl ; so the caller will put the char in the bl 
  int 10h ; call bios (this can be done with the drivers but we need a system to make letters grapichs)..
  
