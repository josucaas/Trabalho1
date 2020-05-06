.text
	.globl main
main:	
addi		$sp, $sp, -16 	 	#Abrindo 4 espaços na pilha
la		$t0, A			#Endeço do vetor
sw 		$t0, 0($sp)		#Inserindo o vetor na pilha
la		$t0, Prim		#Primeiro indice
lw		$t0, 0($t0)
sw	 	$t0, 4($sp)
la		$t0, Ult		#Ultimo indice
lw		$t0, 0($t0)
sw 		$t0, 8($sp)
la		$t0, Valor		#Valor procurado
lw		$t0, 0($t0)
sw	 	$t0, 12($sp)		
jal 		BinSearch
move 		$a0,$v0			#Pega o valor de Binsearch a ser printado
li 		$v0, 1			
syscall	
li		$v0, 10			#Finaliza o programa
syscall

BinSearch:
lw		$t0, 0($sp)		# Endereço do vetor	$t0 = A
lw		$t1, 4($sp)		# Prim indice		$t1 = Prim
lw		$t2, 8($sp)		# Ultimo indice		$t2 = Ult
lw		$t3, 12($sp)		# Valor procurado	$t3 = Valor
addi		$sp, $sp, 16 		# Libera os espaços da pilha

addi		$sp, $sp, -4		# Abre 4 espaços para o $ra
sw		$ra, 0($sp)

# if (Prim > Ult)
slt 		$t4, $t2, $t1 		#			$t4 = 1 if $t1 > $t2 else 0
bne 		$t4, $zero, ValorNaoExiste	#Se o menor era o $t2, retorna -1 pois significa que o ultimo era menor do que o primeiro

# int Meio = (Prim + Ult)/2;
add		$t4, $t1, $t2		#			$t4 = (Prim + Ult)
li		$t5, 2			# cria a variavel 2
div 		$t4, $t5		#			$t4 = MEIO
mflo		$t4			# carrega o valor guardado em lo

# if (Valor == A[Meio])
li		$t5, 4			# cria a variavel de valor 4
mult 		$t4, $t5		# 4 * o índice "meio"
mflo		$t6			# pega o resultado da mult em lo
add		$t6, $t6, $t0		# soma o novo índice ao base do array
lw		$t6, 0($t6)		# carrega o valor contido em "meio"
beq		$t6, $t3, ValorEncontradoMeio 

# else if (Valor<A[Meio])
slt		$t6, $t3, $t6		#			$t6 = 1 if $t3 < $t6 else 0
bne		$t6, $zero, ValorMenorDoQueMeio	# verdade se valor procurado for menor do que o valor meio

# else return BinSearch(A, Meio+1, Ult, Valor);
j		ValorMaiorDoQueMeio		

                  
ValorMenorDoQueMeio:
addi 		$sp, $sp, -16 	 	# Abrindo 4 espaços na pilha
la		$t0, A			# Endeço do vetor
sw 		$t0, 0($sp)		# Inserindo o vetor na pilha
move		$t0, $t1		# Primeiro indice
sw	 	$t0, 4($sp)
subi		$t4, $t4, 1		# Meio -1
move		$t0, $t4		# Ultimo indice
sw 		$t0, 8($sp)
move		$t0, $t3		# Valor procurado
sw	 	$t0, 12($sp)		
jal		BinSearch
lw		$ra, 0($sp)		# recupera o $ra anterior
addi		$sp, $sp, 4
jr		$ra


ValorMaiorDoQueMeio:      
addi		$sp, $sp, -16 	 	#Abrindo 4 espaços na pilha
la		$t0, A			#Endeço do vetor
sw 		$t0, 0($sp)		#Inserindo o vetor na pilha
addi		$t4, $t4, 1		# Meio +1
move		$t0, $t4		#Primeiro indice
sw	 	$t0, 4($sp)
move 		$t0, $t2		#Ultimo indice
sw 		$t0, 8($sp)
move		$t0, $t3		#Valor procurado
sw	 	$t0, 12($sp)		
jal		BinSearch                         
lw		$ra, 0($sp)
addi		$sp, $sp, 4
jr		$ra
                         
                                                                                   
ValorEncontradoMeio:
move 		$v0, $t4
jr   		$ra


ValorNaoExiste:
li		$v0, -1
jr		$ra
                                                                                                            






.data
A: 	.word  -5 -1 5 9 12 15 21 29 31 58 250 325
Prim:   .word   0
Ult:    .word  11
Valor:  .word 250
