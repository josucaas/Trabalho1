.text
	.globl main
main:
addiu 	$sp, $sp, -16 	 	#Abrindo 4 espaços na pilha
la		$t0, A			#Endeço do vetor
sw 		$t0, 0($sp)		#Inserindo o vetor na pilha
li		$t0, 0			#Primeiro indice
sw	 	$t0, 4($sp)
li		$t0, 11			#Ultimo indice
sw 		$t0, 8($sp)
li		$t0, 250			#Valor procurado
sw	 	$t0, 12($sp)		
jal 		BinSearch
move 	$a0,$v0			#Pega o valor de Binsearch a ser printado
li 		$v0, 1			
syscall	
li		$v0, 10			#Finaliza o programa
syscall

BinSearch:
lw		$t0, 0($sp)	#Endereço do vetor	
lw		$t1, 4($sp)	#Prim indice
lw		$t2, 8($sp)	#Ultimo indice
lw		$t3, 12($sp)	#Valor procurado
addiu	$sp, $sp, 12 	#Desempilhando
slt 		$t4, $t1, $t2 	#$t4 recebe o menor entre o $t1 e $t2
bne 		$t4, 1, ValorNaoExiste	#Testa se o menor não era o $t1
add		$t4, $t1, $t2
div 		$t4, $t4, 2



   
li		$v0, 10			#Finaliza o programa
syscall

                  
                                    
                                                      
                                                                        
ValorNaoExiste:
li	$v0, -1
jr	$ra
                                                                                                            






.data
A: .word  -5 -1 5 9 12 15 21 29 31 58 250 325

