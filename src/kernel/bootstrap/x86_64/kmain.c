
extern "c" setuppaging(void);
//extern "c" ShowMenu(); // need to be implemented in asm so we can do interupts and call bios to draw



int kmain(){  

  if (!setuppaging();)
  {
     return -44;
  }
  
  //ShowMenu();
  
  
  return 0;
}
