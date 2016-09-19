/*
  general driver for simple output and input those drivers are not meant to be used by the kernel 
  but used for making of more specific drivers like print(); 
*/ // written by antonio trpeski


unsigned char PortIOinByte( unsigned short port ) {

unsigned char data;

__asm__ (" in %% dx , %% al " : "=a " ( data ) : "d " ( port ));

return data;

}

void portIOoutByte( unsigned short port , unsigned char data ) {

__asm__ (" out %% al , %% dx " : :" a" ( data ), "d" ( port ));

}

unsigned short portIOinWord( unsigned short port ) {

unsigned short data;

__asm__ (" in %% dx , %% ax " : "=a " ( data ) : "d " ( port ));

return data;

}

void portIOoutWord( unsigned short port , unsigned short data ) {

__asm__ (" out %% ax , %% dx " : :" a" ( data ), "d" ( port ));

}
