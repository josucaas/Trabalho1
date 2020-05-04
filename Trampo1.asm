.text
	.globl main
main:	
addiu 		$sp, $sp, -16 	 	#Abrindo 4 espaços na pilha
la		$t0, A			#Endeço do vetor
sw 		$t0, 0($sp)		#Inserindo o vetor na pilha
li		$t0, 0			#Primeiro indice
sw	 	$t0, 4($sp)
li		$t0, 11			#Ultimo indice
sw 		$t0, 8($sp)
li		$t0, -5			#Valor procurado
sw	 	$t0, 12($sp)		
jal 		BinSearch
#addiu 		$sp, $sp, 16
move 		$a0,$v0			#Pega o valor de Binsearch a ser printado
li 		$v0, 1			
syscall	
li		$v0, 10			#Finaliza o programa
syscall

BinSearch:
lw		$t0, 0($sp)		#Endereço do vetor	$t0 = A
lw		$t1, 4($sp)		#Prim indice		$t1 = Prim
lw		$t2, 8($sp)		#Ultimo indice		$t2 = Ult
lw		$t3, 12($sp)		#Valor procurado	$t3 = Valor
addiu		$sp, $sp, 16 			#Libera os espaços da pilha
slt 		$t4, $t2, $t1 		#			$t4 = 1 if $t1 > $t2 else 0
bne 		$t4, $zero, ValorNaoExiste	#Se o menor era o $t2, retorna -1 pois significa que o ultimo era menor do que o primeiro
add		$t4, $t1, $t2		#			$t4 = (Prim + Ult)
div 		$t4, $t4, 2		#			$t4 = MEIO
li		$t5, 4			# cria a variavel de valor 4
mul		$t6, $t4, $t5		# 4 * o índice "meio"
add		$t6, $t6, $t0		# soma o novo índice ao base do array
lw		$t6, 0($t6)		# carrega o valor contido em "meio"
beq		$t6, $t3, ValorEncontradoMeio 
slt		$t6, $t3, $t6		#			$t6 = 1 if $t3 < $t6 else 0
bne		$t6, $zero, ValorMenorDoQueMeio	# verdade se valor procurado for menor do que o valor meio
j		ValorMaiorDoQueMeio		





li		$v0, 10			#Finaliza o programa
syscall

                  
ValorMenorDoQueMeio:
addiu 		$sp, $sp, -16 	 	#Abrindo 4 espaços na pilha
la		$t0, A			#Endeço do vetor
sw 		$t0, 0($sp)		#Inserindo o vetor na pilha
move		$t0, $t1		#Primeiro indice
sw	 	$t0, 4($sp)
subi		$t4, $t4, 1		# Meio -1
move		$t0, $t4		#Ultimo indice
sw 		$t0, 8($sp)
move		$t0, $t3		#Valor procurado
sw	 	$t0, 12($sp)		
j		BinSearch


ValorMaiorDoQueMeio:      
addiu 		$sp, $sp, -16 	 	#Abrindo 4 espaços na pilha
la		$t0, A			#Endeço do vetor
sw 		$t0, 0($sp)		#Inserindo o vetor na pilha
addi		$t4, $t4, 1		# Meio +1
move		$t0, $t4		#Primeiro indice
sw	 	$t0, 4($sp)
move 		$t0, $t2		#Ultimo indice
sw 		$t0, 8($sp)
move		$t0, $t3		#Valor procurado
sw	 	$t0, 12($sp)		
j		BinSearch                         
                                                      
ValorEncontradoMeio:
move 		$v0, $t4
jr   		$ra

ValorNaoExiste:
li		$v0, -1
jr		$ra
                                                                                                            






.data
A: .word  -5 -1 5 9 12 15 21 29 31 58 250 325

