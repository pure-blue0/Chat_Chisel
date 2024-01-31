
32riscv-elf/test_arithmetic.riscv:     file format elf32-littleriscv


Disassembly of section .text:

00010074 <register_fini>:
   10074:	000007b7          	lui	a5,0x0
   10078:	00078793          	mv	a5,a5
   1007c:	00078863          	beqz	a5,1008c <register_fini+0x18>
   10080:	00010537          	lui	a0,0x10
   10084:	72050513          	addi	a0,a0,1824 # 10720 <__libc_fini_array>
   10088:	6f40006f          	j	1077c <atexit>
   1008c:	00008067          	ret

00010090 <_start>:
   10090:	00002197          	auipc	gp,0x2
   10094:	ff818193          	addi	gp,gp,-8 # 12088 <__global_pointer$>
   10098:	c3418513          	addi	a0,gp,-972 # 11cbc <_edata>
   1009c:	c5018613          	addi	a2,gp,-944 # 11cd8 <__BSS_END__>
   100a0:	40a60633          	sub	a2,a2,a0
   100a4:	00000593          	li	a1,0
   100a8:	47c000ef          	jal	ra,10524 <memset>
   100ac:	00000517          	auipc	a0,0x0
   100b0:	6d050513          	addi	a0,a0,1744 # 1077c <atexit>
   100b4:	00050863          	beqz	a0,100c4 <_start+0x34>
   100b8:	00000517          	auipc	a0,0x0
   100bc:	66850513          	addi	a0,a0,1640 # 10720 <__libc_fini_array>
   100c0:	6bc000ef          	jal	ra,1077c <atexit>
   100c4:	3c4000ef          	jal	ra,10488 <__libc_init_array>
   100c8:	00012503          	lw	a0,0(sp)
   100cc:	00410593          	addi	a1,sp,4
   100d0:	00000613          	li	a2,0
   100d4:	07c000ef          	jal	ra,10150 <main>
   100d8:	3800006f          	j	10458 <exit>

000100dc <__do_global_dtors_aux>:
   100dc:	c341c703          	lbu	a4,-972(gp) # 11cbc <_edata>
   100e0:	04071463          	bnez	a4,10128 <__do_global_dtors_aux+0x4c>
   100e4:	ff010113          	addi	sp,sp,-16
   100e8:	00812423          	sw	s0,8(sp)
   100ec:	00078413          	mv	s0,a5
   100f0:	000007b7          	lui	a5,0x0
   100f4:	00112623          	sw	ra,12(sp)
   100f8:	00078793          	mv	a5,a5
   100fc:	00078a63          	beqz	a5,10110 <__do_global_dtors_aux+0x34>
   10100:	00012537          	lui	a0,0x12
   10104:	87450513          	addi	a0,a0,-1932 # 11874 <__FRAME_END__>
   10108:	00000097          	auipc	ra,0x0
   1010c:	000000e7          	jalr	zero # 0 <register_fini-0x10074>
   10110:	00100793          	li	a5,1
   10114:	00c12083          	lw	ra,12(sp)
   10118:	c2f18a23          	sb	a5,-972(gp) # 11cbc <_edata>
   1011c:	00812403          	lw	s0,8(sp)
   10120:	01010113          	addi	sp,sp,16
   10124:	00008067          	ret
   10128:	00008067          	ret

0001012c <frame_dummy>:
   1012c:	000007b7          	lui	a5,0x0
   10130:	00078793          	mv	a5,a5
   10134:	00078c63          	beqz	a5,1014c <frame_dummy+0x20>
   10138:	00012537          	lui	a0,0x12
   1013c:	c3818593          	addi	a1,gp,-968 # 11cc0 <object.5495>
   10140:	87450513          	addi	a0,a0,-1932 # 11874 <__FRAME_END__>
   10144:	00000317          	auipc	t1,0x0
   10148:	00000067          	jr	zero # 0 <register_fini-0x10074>
   1014c:	00008067          	ret

00010150 <main>:
   10150:	fc010113          	addi	sp,sp,-64
   10154:	02112e23          	sw	ra,60(sp)
   10158:	02812c23          	sw	s0,56(sp)
   1015c:	04010413          	addi	s0,sp,64
   10160:	00a00793          	li	a5,10
   10164:	fef42623          	sw	a5,-20(s0)
   10168:	01400793          	li	a5,20
   1016c:	fef42423          	sw	a5,-24(s0)
   10170:	01e00793          	li	a5,30
   10174:	fef42223          	sw	a5,-28(s0)
   10178:	000037b7          	lui	a5,0x3
   1017c:	03978793          	addi	a5,a5,57 # 3039 <register_fini-0xd03b>
   10180:	fef42023          	sw	a5,-32(s0)
   10184:	00100793          	li	a5,1
   10188:	fcf42e23          	sw	a5,-36(s0)
   1018c:	00200793          	li	a5,2
   10190:	fcf42c23          	sw	a5,-40(s0)
   10194:	fec42703          	lw	a4,-20(s0)
   10198:	fe842783          	lw	a5,-24(s0)
   1019c:	00f707b3          	add	a5,a4,a5
   101a0:	fcf42a23          	sw	a5,-44(s0)
   101a4:	fd442503          	lw	a0,-44(s0)
   101a8:	0cc000ef          	jal	ra,10274 <print_d>
   101ac:	00a00513          	li	a0,10
   101b0:	114000ef          	jal	ra,102c4 <print_c>
   101b4:	fec42703          	lw	a4,-20(s0)
   101b8:	fe842783          	lw	a5,-24(s0)
   101bc:	40f707b3          	sub	a5,a4,a5
   101c0:	fcf42823          	sw	a5,-48(s0)
   101c4:	fd042503          	lw	a0,-48(s0)
   101c8:	0ac000ef          	jal	ra,10274 <print_d>
   101cc:	00a00513          	li	a0,10
   101d0:	0f4000ef          	jal	ra,102c4 <print_c>
   101d4:	fe042583          	lw	a1,-32(s0)
   101d8:	fe442503          	lw	a0,-28(s0)
   101dc:	1a4000ef          	jal	ra,10380 <__mulsi3>
   101e0:	00050793          	mv	a5,a0
   101e4:	fcf42623          	sw	a5,-52(s0)
   101e8:	fcc42503          	lw	a0,-52(s0)
   101ec:	088000ef          	jal	ra,10274 <print_d>
   101f0:	00a00513          	li	a0,10
   101f4:	0d0000ef          	jal	ra,102c4 <print_c>
   101f8:	fe442583          	lw	a1,-28(s0)
   101fc:	fe042503          	lw	a0,-32(s0)
   10200:	1a4000ef          	jal	ra,103a4 <__divsi3>
   10204:	00050793          	mv	a5,a0
   10208:	fcf42a23          	sw	a5,-44(s0)
   1020c:	fd442503          	lw	a0,-44(s0)
   10210:	064000ef          	jal	ra,10274 <print_d>
   10214:	00a00513          	li	a0,10
   10218:	0ac000ef          	jal	ra,102c4 <print_c>
   1021c:	fd842783          	lw	a5,-40(s0)
   10220:	fe042703          	lw	a4,-32(s0)
   10224:	00f717b3          	sll	a5,a4,a5
   10228:	fcf42823          	sw	a5,-48(s0)
   1022c:	fd042503          	lw	a0,-48(s0)
   10230:	044000ef          	jal	ra,10274 <print_d>
   10234:	00a00513          	li	a0,10
   10238:	08c000ef          	jal	ra,102c4 <print_c>
   1023c:	fe042783          	lw	a5,-32(s0)
   10240:	4047d793          	srai	a5,a5,0x4
   10244:	fcf42623          	sw	a5,-52(s0)
   10248:	fcc42503          	lw	a0,-52(s0)
   1024c:	028000ef          	jal	ra,10274 <print_d>
   10250:	00a00513          	li	a0,10
   10254:	070000ef          	jal	ra,102c4 <print_c>
   10258:	098000ef          	jal	ra,102f0 <exit_proc>
   1025c:	00000793          	li	a5,0
   10260:	00078513          	mv	a0,a5
   10264:	03c12083          	lw	ra,60(sp)
   10268:	03812403          	lw	s0,56(sp)
   1026c:	04010113          	addi	sp,sp,64
   10270:	00008067          	ret

00010274 <print_d>:
   10274:	fe010113          	addi	sp,sp,-32
   10278:	00812e23          	sw	s0,28(sp)
   1027c:	02010413          	addi	s0,sp,32
   10280:	fea42623          	sw	a0,-20(s0)
   10284:	00200893          	li	a7,2
   10288:	00000073          	ecall
   1028c:	00000013          	nop
   10290:	01c12403          	lw	s0,28(sp)
   10294:	02010113          	addi	sp,sp,32
   10298:	00008067          	ret

0001029c <print_s>:
   1029c:	fe010113          	addi	sp,sp,-32
   102a0:	00812e23          	sw	s0,28(sp)
   102a4:	02010413          	addi	s0,sp,32
   102a8:	fea42623          	sw	a0,-20(s0)
   102ac:	00000893          	li	a7,0
   102b0:	00000073          	ecall
   102b4:	00000013          	nop
   102b8:	01c12403          	lw	s0,28(sp)
   102bc:	02010113          	addi	sp,sp,32
   102c0:	00008067          	ret

000102c4 <print_c>:
   102c4:	fe010113          	addi	sp,sp,-32
   102c8:	00812e23          	sw	s0,28(sp)
   102cc:	02010413          	addi	s0,sp,32
   102d0:	00050793          	mv	a5,a0
   102d4:	fef407a3          	sb	a5,-17(s0)
   102d8:	00100893          	li	a7,1
   102dc:	00000073          	ecall
   102e0:	00000013          	nop
   102e4:	01c12403          	lw	s0,28(sp)
   102e8:	02010113          	addi	sp,sp,32
   102ec:	00008067          	ret

000102f0 <exit_proc>:
   102f0:	ff010113          	addi	sp,sp,-16
   102f4:	00812623          	sw	s0,12(sp)
   102f8:	01010413          	addi	s0,sp,16
   102fc:	00300893          	li	a7,3
   10300:	00000073          	ecall
   10304:	00000013          	nop
   10308:	00c12403          	lw	s0,12(sp)
   1030c:	01010113          	addi	sp,sp,16
   10310:	00008067          	ret

00010314 <read_char>:
   10314:	fe010113          	addi	sp,sp,-32
   10318:	00812e23          	sw	s0,28(sp)
   1031c:	02010413          	addi	s0,sp,32
   10320:	00400893          	li	a7,4
   10324:	00000073          	ecall
   10328:	00050793          	mv	a5,a0
   1032c:	fef407a3          	sb	a5,-17(s0)
   10330:	fef44783          	lbu	a5,-17(s0)
   10334:	00078513          	mv	a0,a5
   10338:	01c12403          	lw	s0,28(sp)
   1033c:	02010113          	addi	sp,sp,32
   10340:	00008067          	ret

00010344 <read_num>:
   10344:	fe010113          	addi	sp,sp,-32
   10348:	00812e23          	sw	s0,28(sp)
   1034c:	02010413          	addi	s0,sp,32
   10350:	00500893          	li	a7,5
   10354:	00000073          	ecall
   10358:	00050713          	mv	a4,a0
   1035c:	fee42423          	sw	a4,-24(s0)
   10360:	fef42623          	sw	a5,-20(s0)
   10364:	fe842703          	lw	a4,-24(s0)
   10368:	fec42783          	lw	a5,-20(s0)
   1036c:	00070513          	mv	a0,a4
   10370:	00078593          	mv	a1,a5
   10374:	01c12403          	lw	s0,28(sp)
   10378:	02010113          	addi	sp,sp,32
   1037c:	00008067          	ret

00010380 <__mulsi3>:
   10380:	00050613          	mv	a2,a0
   10384:	00000513          	li	a0,0
   10388:	0015f693          	andi	a3,a1,1
   1038c:	00068463          	beqz	a3,10394 <__mulsi3+0x14>
   10390:	00c50533          	add	a0,a0,a2
   10394:	0015d593          	srli	a1,a1,0x1
   10398:	00161613          	slli	a2,a2,0x1
   1039c:	fe0596e3          	bnez	a1,10388 <__mulsi3+0x8>
   103a0:	00008067          	ret

000103a4 <__divsi3>:
   103a4:	06054063          	bltz	a0,10404 <__umodsi3+0x10>
   103a8:	0605c663          	bltz	a1,10414 <__umodsi3+0x20>

000103ac <__udivsi3>:
   103ac:	00058613          	mv	a2,a1
   103b0:	00050593          	mv	a1,a0
   103b4:	fff00513          	li	a0,-1
   103b8:	02060c63          	beqz	a2,103f0 <__udivsi3+0x44>
   103bc:	00100693          	li	a3,1
   103c0:	00b67a63          	bgeu	a2,a1,103d4 <__udivsi3+0x28>
   103c4:	00c05863          	blez	a2,103d4 <__udivsi3+0x28>
   103c8:	00161613          	slli	a2,a2,0x1
   103cc:	00169693          	slli	a3,a3,0x1
   103d0:	feb66ae3          	bltu	a2,a1,103c4 <__udivsi3+0x18>
   103d4:	00000513          	li	a0,0
   103d8:	00c5e663          	bltu	a1,a2,103e4 <__udivsi3+0x38>
   103dc:	40c585b3          	sub	a1,a1,a2
   103e0:	00d56533          	or	a0,a0,a3
   103e4:	0016d693          	srli	a3,a3,0x1
   103e8:	00165613          	srli	a2,a2,0x1
   103ec:	fe0696e3          	bnez	a3,103d8 <__udivsi3+0x2c>
   103f0:	00008067          	ret

000103f4 <__umodsi3>:
   103f4:	00008293          	mv	t0,ra
   103f8:	fb5ff0ef          	jal	ra,103ac <__udivsi3>
   103fc:	00058513          	mv	a0,a1
   10400:	00028067          	jr	t0
   10404:	40a00533          	neg	a0,a0
   10408:	0005d863          	bgez	a1,10418 <__umodsi3+0x24>
   1040c:	40b005b3          	neg	a1,a1
   10410:	f9dff06f          	j	103ac <__udivsi3>
   10414:	40b005b3          	neg	a1,a1
   10418:	00008293          	mv	t0,ra
   1041c:	f91ff0ef          	jal	ra,103ac <__udivsi3>
   10420:	40a00533          	neg	a0,a0
   10424:	00028067          	jr	t0

00010428 <__modsi3>:
   10428:	00008293          	mv	t0,ra
   1042c:	0005ca63          	bltz	a1,10440 <__modsi3+0x18>
   10430:	00054c63          	bltz	a0,10448 <__modsi3+0x20>
   10434:	f79ff0ef          	jal	ra,103ac <__udivsi3>
   10438:	00058513          	mv	a0,a1
   1043c:	00028067          	jr	t0
   10440:	40b005b3          	neg	a1,a1
   10444:	fe0558e3          	bgez	a0,10434 <__modsi3+0xc>
   10448:	40a00533          	neg	a0,a0
   1044c:	f61ff0ef          	jal	ra,103ac <__udivsi3>
   10450:	40b00533          	neg	a0,a1
   10454:	00028067          	jr	t0

00010458 <exit>:
   10458:	ff010113          	addi	sp,sp,-16
   1045c:	00000593          	li	a1,0
   10460:	00812423          	sw	s0,8(sp)
   10464:	00112623          	sw	ra,12(sp)
   10468:	00050413          	mv	s0,a0
   1046c:	194000ef          	jal	ra,10600 <__call_exitprocs>
   10470:	c281a503          	lw	a0,-984(gp) # 11cb0 <_global_impure_ptr>
   10474:	03c52783          	lw	a5,60(a0)
   10478:	00078463          	beqz	a5,10480 <exit+0x28>
   1047c:	000780e7          	jalr	a5
   10480:	00040513          	mv	a0,s0
   10484:	3a4000ef          	jal	ra,10828 <_exit>

00010488 <__libc_init_array>:
   10488:	ff010113          	addi	sp,sp,-16
   1048c:	00812423          	sw	s0,8(sp)
   10490:	01212023          	sw	s2,0(sp)
   10494:	00012437          	lui	s0,0x12
   10498:	00012937          	lui	s2,0x12
   1049c:	87840793          	addi	a5,s0,-1928 # 11878 <__init_array_start>
   104a0:	87890913          	addi	s2,s2,-1928 # 11878 <__init_array_start>
   104a4:	40f90933          	sub	s2,s2,a5
   104a8:	00112623          	sw	ra,12(sp)
   104ac:	00912223          	sw	s1,4(sp)
   104b0:	40295913          	srai	s2,s2,0x2
   104b4:	02090063          	beqz	s2,104d4 <__libc_init_array+0x4c>
   104b8:	87840413          	addi	s0,s0,-1928
   104bc:	00000493          	li	s1,0
   104c0:	00042783          	lw	a5,0(s0)
   104c4:	00148493          	addi	s1,s1,1
   104c8:	00440413          	addi	s0,s0,4
   104cc:	000780e7          	jalr	a5
   104d0:	fe9918e3          	bne	s2,s1,104c0 <__libc_init_array+0x38>
   104d4:	00012437          	lui	s0,0x12
   104d8:	00012937          	lui	s2,0x12
   104dc:	87840793          	addi	a5,s0,-1928 # 11878 <__init_array_start>
   104e0:	88090913          	addi	s2,s2,-1920 # 11880 <__init_array_end>
   104e4:	40f90933          	sub	s2,s2,a5
   104e8:	40295913          	srai	s2,s2,0x2
   104ec:	02090063          	beqz	s2,1050c <__libc_init_array+0x84>
   104f0:	87840413          	addi	s0,s0,-1928
   104f4:	00000493          	li	s1,0
   104f8:	00042783          	lw	a5,0(s0)
   104fc:	00148493          	addi	s1,s1,1
   10500:	00440413          	addi	s0,s0,4
   10504:	000780e7          	jalr	a5
   10508:	fe9918e3          	bne	s2,s1,104f8 <__libc_init_array+0x70>
   1050c:	00c12083          	lw	ra,12(sp)
   10510:	00812403          	lw	s0,8(sp)
   10514:	00412483          	lw	s1,4(sp)
   10518:	00012903          	lw	s2,0(sp)
   1051c:	01010113          	addi	sp,sp,16
   10520:	00008067          	ret

00010524 <memset>:
   10524:	00f00313          	li	t1,15
   10528:	00050713          	mv	a4,a0
   1052c:	02c37e63          	bgeu	t1,a2,10568 <memset+0x44>
   10530:	00f77793          	andi	a5,a4,15
   10534:	0a079063          	bnez	a5,105d4 <memset+0xb0>
   10538:	08059263          	bnez	a1,105bc <memset+0x98>
   1053c:	ff067693          	andi	a3,a2,-16
   10540:	00f67613          	andi	a2,a2,15
   10544:	00e686b3          	add	a3,a3,a4
   10548:	00b72023          	sw	a1,0(a4)
   1054c:	00b72223          	sw	a1,4(a4)
   10550:	00b72423          	sw	a1,8(a4)
   10554:	00b72623          	sw	a1,12(a4)
   10558:	01070713          	addi	a4,a4,16
   1055c:	fed766e3          	bltu	a4,a3,10548 <memset+0x24>
   10560:	00061463          	bnez	a2,10568 <memset+0x44>
   10564:	00008067          	ret
   10568:	40c306b3          	sub	a3,t1,a2
   1056c:	00269693          	slli	a3,a3,0x2
   10570:	00000297          	auipc	t0,0x0
   10574:	005686b3          	add	a3,a3,t0
   10578:	00c68067          	jr	12(a3)
   1057c:	00b70723          	sb	a1,14(a4)
   10580:	00b706a3          	sb	a1,13(a4)
   10584:	00b70623          	sb	a1,12(a4)
   10588:	00b705a3          	sb	a1,11(a4)
   1058c:	00b70523          	sb	a1,10(a4)
   10590:	00b704a3          	sb	a1,9(a4)
   10594:	00b70423          	sb	a1,8(a4)
   10598:	00b703a3          	sb	a1,7(a4)
   1059c:	00b70323          	sb	a1,6(a4)
   105a0:	00b702a3          	sb	a1,5(a4)
   105a4:	00b70223          	sb	a1,4(a4)
   105a8:	00b701a3          	sb	a1,3(a4)
   105ac:	00b70123          	sb	a1,2(a4)
   105b0:	00b700a3          	sb	a1,1(a4)
   105b4:	00b70023          	sb	a1,0(a4)
   105b8:	00008067          	ret
   105bc:	0ff5f593          	andi	a1,a1,255
   105c0:	00859693          	slli	a3,a1,0x8
   105c4:	00d5e5b3          	or	a1,a1,a3
   105c8:	01059693          	slli	a3,a1,0x10
   105cc:	00d5e5b3          	or	a1,a1,a3
   105d0:	f6dff06f          	j	1053c <memset+0x18>
   105d4:	00279693          	slli	a3,a5,0x2
   105d8:	00000297          	auipc	t0,0x0
   105dc:	005686b3          	add	a3,a3,t0
   105e0:	00008293          	mv	t0,ra
   105e4:	fa0680e7          	jalr	-96(a3)
   105e8:	00028093          	mv	ra,t0
   105ec:	ff078793          	addi	a5,a5,-16
   105f0:	40f70733          	sub	a4,a4,a5
   105f4:	00f60633          	add	a2,a2,a5
   105f8:	f6c378e3          	bgeu	t1,a2,10568 <memset+0x44>
   105fc:	f3dff06f          	j	10538 <memset+0x14>

00010600 <__call_exitprocs>:
   10600:	fd010113          	addi	sp,sp,-48
   10604:	01412c23          	sw	s4,24(sp)
   10608:	c281aa03          	lw	s4,-984(gp) # 11cb0 <_global_impure_ptr>
   1060c:	03212023          	sw	s2,32(sp)
   10610:	02112623          	sw	ra,44(sp)
   10614:	148a2903          	lw	s2,328(s4)
   10618:	02812423          	sw	s0,40(sp)
   1061c:	02912223          	sw	s1,36(sp)
   10620:	01312e23          	sw	s3,28(sp)
   10624:	01512a23          	sw	s5,20(sp)
   10628:	01612823          	sw	s6,16(sp)
   1062c:	01712623          	sw	s7,12(sp)
   10630:	01812423          	sw	s8,8(sp)
   10634:	04090063          	beqz	s2,10674 <__call_exitprocs+0x74>
   10638:	00050b13          	mv	s6,a0
   1063c:	00058b93          	mv	s7,a1
   10640:	00100a93          	li	s5,1
   10644:	fff00993          	li	s3,-1
   10648:	00492483          	lw	s1,4(s2)
   1064c:	fff48413          	addi	s0,s1,-1
   10650:	02044263          	bltz	s0,10674 <__call_exitprocs+0x74>
   10654:	00249493          	slli	s1,s1,0x2
   10658:	009904b3          	add	s1,s2,s1
   1065c:	040b8463          	beqz	s7,106a4 <__call_exitprocs+0xa4>
   10660:	1044a783          	lw	a5,260(s1)
   10664:	05778063          	beq	a5,s7,106a4 <__call_exitprocs+0xa4>
   10668:	fff40413          	addi	s0,s0,-1
   1066c:	ffc48493          	addi	s1,s1,-4
   10670:	ff3416e3          	bne	s0,s3,1065c <__call_exitprocs+0x5c>
   10674:	02c12083          	lw	ra,44(sp)
   10678:	02812403          	lw	s0,40(sp)
   1067c:	02412483          	lw	s1,36(sp)
   10680:	02012903          	lw	s2,32(sp)
   10684:	01c12983          	lw	s3,28(sp)
   10688:	01812a03          	lw	s4,24(sp)
   1068c:	01412a83          	lw	s5,20(sp)
   10690:	01012b03          	lw	s6,16(sp)
   10694:	00c12b83          	lw	s7,12(sp)
   10698:	00812c03          	lw	s8,8(sp)
   1069c:	03010113          	addi	sp,sp,48
   106a0:	00008067          	ret
   106a4:	00492783          	lw	a5,4(s2)
   106a8:	0044a683          	lw	a3,4(s1)
   106ac:	fff78793          	addi	a5,a5,-1
   106b0:	04878e63          	beq	a5,s0,1070c <__call_exitprocs+0x10c>
   106b4:	0004a223          	sw	zero,4(s1)
   106b8:	fa0688e3          	beqz	a3,10668 <__call_exitprocs+0x68>
   106bc:	18892783          	lw	a5,392(s2)
   106c0:	008a9733          	sll	a4,s5,s0
   106c4:	00492c03          	lw	s8,4(s2)
   106c8:	00f777b3          	and	a5,a4,a5
   106cc:	02079263          	bnez	a5,106f0 <__call_exitprocs+0xf0>
   106d0:	000680e7          	jalr	a3
   106d4:	00492703          	lw	a4,4(s2)
   106d8:	148a2783          	lw	a5,328(s4)
   106dc:	01871463          	bne	a4,s8,106e4 <__call_exitprocs+0xe4>
   106e0:	f8f904e3          	beq	s2,a5,10668 <__call_exitprocs+0x68>
   106e4:	f80788e3          	beqz	a5,10674 <__call_exitprocs+0x74>
   106e8:	00078913          	mv	s2,a5
   106ec:	f5dff06f          	j	10648 <__call_exitprocs+0x48>
   106f0:	18c92783          	lw	a5,396(s2)
   106f4:	0844a583          	lw	a1,132(s1)
   106f8:	00f77733          	and	a4,a4,a5
   106fc:	00071c63          	bnez	a4,10714 <__call_exitprocs+0x114>
   10700:	000b0513          	mv	a0,s6
   10704:	000680e7          	jalr	a3
   10708:	fcdff06f          	j	106d4 <__call_exitprocs+0xd4>
   1070c:	00892223          	sw	s0,4(s2)
   10710:	fa9ff06f          	j	106b8 <__call_exitprocs+0xb8>
   10714:	00058513          	mv	a0,a1
   10718:	000680e7          	jalr	a3
   1071c:	fb9ff06f          	j	106d4 <__call_exitprocs+0xd4>

00010720 <__libc_fini_array>:
   10720:	ff010113          	addi	sp,sp,-16
   10724:	00812423          	sw	s0,8(sp)
   10728:	000127b7          	lui	a5,0x12
   1072c:	00012437          	lui	s0,0x12
   10730:	88040413          	addi	s0,s0,-1920 # 11880 <__init_array_end>
   10734:	88478793          	addi	a5,a5,-1916 # 11884 <__fini_array_end>
   10738:	408787b3          	sub	a5,a5,s0
   1073c:	00912223          	sw	s1,4(sp)
   10740:	00112623          	sw	ra,12(sp)
   10744:	4027d493          	srai	s1,a5,0x2
   10748:	02048063          	beqz	s1,10768 <__libc_fini_array+0x48>
   1074c:	ffc78793          	addi	a5,a5,-4
   10750:	00878433          	add	s0,a5,s0
   10754:	00042783          	lw	a5,0(s0)
   10758:	fff48493          	addi	s1,s1,-1
   1075c:	ffc40413          	addi	s0,s0,-4
   10760:	000780e7          	jalr	a5
   10764:	fe0498e3          	bnez	s1,10754 <__libc_fini_array+0x34>
   10768:	00c12083          	lw	ra,12(sp)
   1076c:	00812403          	lw	s0,8(sp)
   10770:	00412483          	lw	s1,4(sp)
   10774:	01010113          	addi	sp,sp,16
   10778:	00008067          	ret

0001077c <atexit>:
   1077c:	00050593          	mv	a1,a0
   10780:	00000693          	li	a3,0
   10784:	00000613          	li	a2,0
   10788:	00000513          	li	a0,0
   1078c:	0040006f          	j	10790 <__register_exitproc>

00010790 <__register_exitproc>:
   10790:	c281a703          	lw	a4,-984(gp) # 11cb0 <_global_impure_ptr>
   10794:	14872783          	lw	a5,328(a4)
   10798:	04078c63          	beqz	a5,107f0 <__register_exitproc+0x60>
   1079c:	0047a703          	lw	a4,4(a5)
   107a0:	01f00813          	li	a6,31
   107a4:	06e84e63          	blt	a6,a4,10820 <__register_exitproc+0x90>
   107a8:	00271813          	slli	a6,a4,0x2
   107ac:	02050663          	beqz	a0,107d8 <__register_exitproc+0x48>
   107b0:	01078333          	add	t1,a5,a6
   107b4:	08c32423          	sw	a2,136(t1) # 101cc <main+0x7c>
   107b8:	1887a883          	lw	a7,392(a5)
   107bc:	00100613          	li	a2,1
   107c0:	00e61633          	sll	a2,a2,a4
   107c4:	00c8e8b3          	or	a7,a7,a2
   107c8:	1917a423          	sw	a7,392(a5)
   107cc:	10d32423          	sw	a3,264(t1)
   107d0:	00200693          	li	a3,2
   107d4:	02d50463          	beq	a0,a3,107fc <__register_exitproc+0x6c>
   107d8:	00170713          	addi	a4,a4,1
   107dc:	00e7a223          	sw	a4,4(a5)
   107e0:	010787b3          	add	a5,a5,a6
   107e4:	00b7a423          	sw	a1,8(a5)
   107e8:	00000513          	li	a0,0
   107ec:	00008067          	ret
   107f0:	14c70793          	addi	a5,a4,332
   107f4:	14f72423          	sw	a5,328(a4)
   107f8:	fa5ff06f          	j	1079c <__register_exitproc+0xc>
   107fc:	18c7a683          	lw	a3,396(a5)
   10800:	00170713          	addi	a4,a4,1
   10804:	00e7a223          	sw	a4,4(a5)
   10808:	00c6e633          	or	a2,a3,a2
   1080c:	18c7a623          	sw	a2,396(a5)
   10810:	010787b3          	add	a5,a5,a6
   10814:	00b7a423          	sw	a1,8(a5)
   10818:	00000513          	li	a0,0
   1081c:	00008067          	ret
   10820:	fff00513          	li	a0,-1
   10824:	00008067          	ret

00010828 <_exit>:
   10828:	00000593          	li	a1,0
   1082c:	00000613          	li	a2,0
   10830:	00000693          	li	a3,0
   10834:	00000713          	li	a4,0
   10838:	00000793          	li	a5,0
   1083c:	05d00893          	li	a7,93
   10840:	00000073          	ecall
   10844:	00054463          	bltz	a0,1084c <_exit+0x24>
   10848:	0000006f          	j	10848 <_exit+0x20>
   1084c:	ff010113          	addi	sp,sp,-16
   10850:	00812423          	sw	s0,8(sp)
   10854:	00050413          	mv	s0,a0
   10858:	00112623          	sw	ra,12(sp)
   1085c:	40800433          	neg	s0,s0
   10860:	00c000ef          	jal	ra,1086c <__errno>
   10864:	00852023          	sw	s0,0(a0)
   10868:	0000006f          	j	10868 <_exit+0x40>

0001086c <__errno>:
   1086c:	c301a503          	lw	a0,-976(gp) # 11cb8 <_impure_ptr>
   10870:	00008067          	ret

Disassembly of section .eh_frame:

00011874 <__FRAME_END__>:
   11874:	0000                	unimp
	...

Disassembly of section .init_array:

00011878 <__init_array_start>:
   11878:	0074                	addi	a3,sp,12
   1187a:	0001                	nop

0001187c <__frame_dummy_init_array_entry>:
   1187c:	012c                	addi	a1,sp,136
   1187e:	0001                	nop

Disassembly of section .fini_array:

00011880 <__do_global_dtors_aux_fini_array_entry>:
   11880:	00dc                	addi	a5,sp,68
   11882:	0001                	nop

Disassembly of section .data:

00011888 <__DATA_BEGIN__>:
   11888:	0000                	unimp
   1188a:	0000                	unimp
   1188c:	1b74                	addi	a3,sp,444
   1188e:	0001                	nop
   11890:	1bdc                	addi	a5,sp,500
   11892:	0001                	nop
   11894:	1c44                	addi	s1,sp,564
   11896:	0001                	nop
	...
   11930:	0001                	nop
   11932:	0000                	unimp
   11934:	0000                	unimp
   11936:	0000                	unimp
   11938:	330e                	fld	ft6,224(sp)
   1193a:	abcd                	j	11f2c <__BSS_END__+0x254>
   1193c:	1234                	addi	a3,sp,296
   1193e:	e66d                	bnez	a2,11a28 <__DATA_BEGIN__+0x1a0>
   11940:	deec                	sw	a1,124(a3)
   11942:	0005                	c.nop	1
   11944:	0000000b          	0xb
	...

Disassembly of section .sdata:

00011cb0 <_global_impure_ptr>:
   11cb0:	1888                	addi	a0,sp,112
   11cb2:	0001                	nop

00011cb4 <__dso_handle>:
   11cb4:	0000                	unimp
	...

00011cb8 <_impure_ptr>:
   11cb8:	1888                	addi	a0,sp,112
   11cba:	0001                	nop

Disassembly of section .bss:

00011cbc <__bss_start>:
   11cbc:	0000                	unimp
	...

00011cc0 <object.5495>:
	...

Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347          	fmsub.d	ft6,ft6,ft4,ft7,rmm
   4:	2820                	fld	fs0,80(s0)
   6:	29554e47          	fmsub.s	ft8,fa0,fs5,ft5,rmm
   a:	3920                	fld	fs0,112(a0)
   c:	322e                	fld	ft4,232(sp)
   e:	302e                	fld	ft0,232(sp)
	...

Disassembly of section .riscv.attributes:

00000000 <.riscv.attributes>:
   0:	1b41                	addi	s6,s6,-16
   2:	0000                	unimp
   4:	7200                	flw	fs0,32(a2)
   6:	7369                	lui	t1,0xffffa
   8:	01007663          	bgeu	zero,a6,14 <register_fini-0x10060>
   c:	0011                	c.nop	4
   e:	0000                	unimp
  10:	1004                	addi	s1,sp,32
  12:	7205                	lui	tp,0xfffe1
  14:	3376                	fld	ft6,376(sp)
  16:	6932                	flw	fs2,12(sp)
  18:	7032                	flw	ft0,44(sp)
  1a:	0030                	addi	a2,sp,8

Disassembly of section .debug_aranges:

00000000 <.debug_aranges>:
   0:	001c                	0x1c
   2:	0000                	unimp
   4:	0002                	c.slli64	zero
   6:	0000                	unimp
   8:	0000                	unimp
   a:	0004                	0x4
   c:	0000                	unimp
   e:	0000                	unimp
  10:	0380                	addi	s0,sp,448
  12:	0001                	nop
  14:	0024                	addi	s1,sp,8
	...
  1e:	0000                	unimp
  20:	001c                	0x1c
  22:	0000                	unimp
  24:	0002                	c.slli64	zero
  26:	0026                	c.slli	zero,0x9
  28:	0000                	unimp
  2a:	0004                	0x4
  2c:	0000                	unimp
  2e:	0000                	unimp
  30:	03a4                	addi	s1,sp,456
  32:	0001                	nop
  34:	00b4                	addi	a3,sp,72
	...

Disassembly of section .debug_info:

00000000 <.debug_info>:
   0:	0022                	c.slli	zero,0x8
   2:	0000                	unimp
   4:	0002                	c.slli64	zero
   6:	0000                	unimp
   8:	0000                	unimp
   a:	0104                	addi	s1,sp,128
   c:	0000                	unimp
   e:	0000                	unimp
  10:	0380                	addi	s0,sp,448
  12:	0001                	nop
  14:	03a4                	addi	s1,sp,456
  16:	0001                	nop
  18:	0000                	unimp
  1a:	0000                	unimp
  1c:	00000033          	add	zero,zero,zero
  20:	0091                	addi	ra,ra,4
  22:	0000                	unimp
  24:	8001                	c.srli64	s0
  26:	0022                	c.slli	zero,0x8
  28:	0000                	unimp
  2a:	0002                	c.slli64	zero
  2c:	0014                	0x14
  2e:	0000                	unimp
  30:	0104                	addi	s1,sp,128
  32:	00000093          	li	ra,0
  36:	03a4                	addi	s1,sp,456
  38:	0001                	nop
  3a:	0458                	addi	a4,sp,516
  3c:	0001                	nop
  3e:	009d                	addi	ra,ra,7
  40:	0000                	unimp
  42:	00000033          	add	zero,zero,zero
  46:	0091                	addi	ra,ra,4
  48:	0000                	unimp
  4a:	8001                	c.srli64	s0

Disassembly of section .debug_abbrev:

00000000 <.debug_abbrev>:
   0:	1101                	addi	sp,sp,-32
   2:	1000                	addi	s0,sp,32
   4:	1106                	slli	sp,sp,0x21
   6:	1201                	addi	tp,tp,-32
   8:	0301                	addi	t1,t1,0
   a:	1b0e                	slli	s6,s6,0x23
   c:	250e                	fld	fa0,192(sp)
   e:	130e                	slli	t1,t1,0x23
  10:	0005                	c.nop	1
  12:	0000                	unimp
  14:	1101                	addi	sp,sp,-32
  16:	1000                	addi	s0,sp,32
  18:	1106                	slli	sp,sp,0x21
  1a:	1201                	addi	tp,tp,-32
  1c:	0301                	addi	t1,t1,0
  1e:	1b0e                	slli	s6,s6,0x23
  20:	250e                	fld	fa0,192(sp)
  22:	130e                	slli	t1,t1,0x23
  24:	0005                	c.nop	1
	...

Disassembly of section .debug_line:

00000000 <.debug_line>:
   0:	0000008f          	0x8f
   4:	00490003          	lb	zero,4(s2)
   8:	0000                	unimp
   a:	0101                	addi	sp,sp,0
   c:	000d0efb          	0xd0efb
  10:	0101                	addi	sp,sp,0
  12:	0101                	addi	sp,sp,0
  14:	0000                	unimp
  16:	0100                	addi	s0,sp,128
  18:	0000                	unimp
  1a:	2e01                	jal	32a <register_fini-0xfd4a>
  1c:	2f2e                	fld	ft10,200(sp)
  1e:	2e2e                	fld	ft8,200(sp)
  20:	2f2e2e2f          	0x2f2e2e2f
  24:	2e2e                	fld	ft8,200(sp)
  26:	7369722f          	0x7369722f
  2a:	672d7663          	bgeu	s10,s2,696 <register_fini-0xf9de>
  2e:	6c2f6363          	bltu	t5,sp,6f4 <register_fini-0xf980>
  32:	6269                	lui	tp,0x1a
  34:	2f636367          	0x2f636367
  38:	666e6f63          	bltu	t3,t1,6b6 <register_fini-0xf9be>
  3c:	6769                	lui	a4,0x1a
  3e:	7369722f          	0x7369722f
  42:	00007663          	bgeu	zero,zero,4e <register_fini-0x10026>
  46:	756d                	lui	a0,0xffffb
  48:	646c                	flw	fa1,76(s0)
  4a:	3369                	jal	fffffdd4 <__global_pointer$+0xfffedd4c>
  4c:	532e                	lw	t1,232(sp)
  4e:	0100                	addi	s0,sp,128
  50:	0000                	unimp
  52:	0000                	unimp
  54:	0205                	addi	tp,tp,1
  56:	0380                	addi	s0,sp,448
  58:	0001                	nop
  5a:	03012403          	lw	s0,48(sp)
  5e:	0901                	addi	s2,s2,0
  60:	0004                	0x4
  62:	0301                	addi	t1,t1,0
  64:	0902                	c.slli64	s2
  66:	0004                	0x4
  68:	0301                	addi	t1,t1,0
  6a:	0901                	addi	s2,s2,0
  6c:	0004                	0x4
  6e:	0301                	addi	t1,t1,0
  70:	0901                	addi	s2,s2,0
  72:	0004                	0x4
  74:	0301                	addi	t1,t1,0
  76:	0902                	c.slli64	s2
  78:	0004                	0x4
  7a:	0301                	addi	t1,t1,0
  7c:	0901                	addi	s2,s2,0
  7e:	0004                	0x4
  80:	0301                	addi	t1,t1,0
  82:	0901                	addi	s2,s2,0
  84:	0004                	0x4
  86:	0301                	addi	t1,t1,0
  88:	0901                	addi	s2,s2,0
  8a:	0004                	0x4
  8c:	0901                	addi	s2,s2,0
  8e:	0004                	0x4
  90:	0100                	addi	s0,sp,128
  92:	6501                	0x6501
  94:	0001                	nop
  96:	0300                	addi	s0,sp,384
  98:	4600                	lw	s0,8(a2)
  9a:	0000                	unimp
  9c:	0100                	addi	s0,sp,128
  9e:	fb01                	bnez	a4,ffffffae <__global_pointer$+0xfffedf26>
  a0:	0d0e                	slli	s10,s10,0x3
  a2:	0100                	addi	s0,sp,128
  a4:	0101                	addi	sp,sp,0
  a6:	0001                	nop
  a8:	0000                	unimp
  aa:	0001                	nop
  ac:	0100                	addi	s0,sp,128
  ae:	2e2e                	fld	ft8,200(sp)
  b0:	2f2e2e2f          	0x2f2e2e2f
  b4:	2e2e                	fld	ft8,200(sp)
  b6:	2f2e2e2f          	0x2f2e2e2f
  ba:	6972                	flw	fs2,28(sp)
  bc:	2d766373          	csrrsi	t1,0x2d7,12
  c0:	2f636367          	0x2f636367
  c4:	696c                	flw	fa1,84(a0)
  c6:	6762                	flw	fa4,24(sp)
  c8:	632f6363          	bltu	t5,s2,6ee <register_fini-0xf986>
  cc:	69666e6f          	jal	t3,66762 <__global_pointer$+0x546da>
  d0:	69722f67          	0x69722f67
  d4:	00766373          	csrrsi	t1,0x7,12
  d8:	6400                	flw	fs0,8(s0)
  da:	7669                	lui	a2,0xffffa
  dc:	532e                	lw	t1,232(sp)
  de:	0100                	addi	s0,sp,128
  e0:	0000                	unimp
  e2:	0000                	unimp
  e4:	0205                	addi	tp,tp,1
  e6:	03a4                	addi	s1,sp,456
  e8:	0001                	nop
  ea:	0100c403          	lbu	s0,16(ra) # 10118 <__do_global_dtors_aux+0x3c>
  ee:	04090103          	lb	sp,64(s2)
  f2:	0100                	addi	s0,sp,128
  f4:	04090403          	lb	s0,64(s2)
  f8:	0100                	addi	s0,sp,128
  fa:	04090103          	lb	sp,64(s2)
  fe:	0100                	addi	s0,sp,128
 100:	04090103          	lb	sp,64(s2)
 104:	0100                	addi	s0,sp,128
 106:	04090103          	lb	sp,64(s2)
 10a:	0100                	addi	s0,sp,128
 10c:	04090103          	lb	sp,64(s2)
 110:	0100                	addi	s0,sp,128
 112:	04090103          	lb	sp,64(s2)
 116:	0100                	addi	s0,sp,128
 118:	04090203          	lb	tp,64(s2)
 11c:	0100                	addi	s0,sp,128
 11e:	04090103          	lb	sp,64(s2)
 122:	0100                	addi	s0,sp,128
 124:	04090103          	lb	sp,64(s2)
 128:	0100                	addi	s0,sp,128
 12a:	04090103          	lb	sp,64(s2)
 12e:	0100                	addi	s0,sp,128
 130:	04090203          	lb	tp,64(s2)
 134:	0100                	addi	s0,sp,128
 136:	04090203          	lb	tp,64(s2)
 13a:	0100                	addi	s0,sp,128
 13c:	04090103          	lb	sp,64(s2)
 140:	0100                	addi	s0,sp,128
 142:	04090103          	lb	sp,64(s2)
 146:	0100                	addi	s0,sp,128
 148:	04090203          	lb	tp,64(s2)
 14c:	0100                	addi	s0,sp,128
 14e:	04090103          	lb	sp,64(s2)
 152:	0100                	addi	s0,sp,128
 154:	04090103          	lb	sp,64(s2)
 158:	0100                	addi	s0,sp,128
 15a:	04090203          	lb	tp,64(s2)
 15e:	0100                	addi	s0,sp,128
 160:	04090503          	lb	a0,64(s2)
 164:	0100                	addi	s0,sp,128
 166:	04090103          	lb	sp,64(s2)
 16a:	0100                	addi	s0,sp,128
 16c:	04090103          	lb	sp,64(s2)
 170:	0100                	addi	s0,sp,128
 172:	04090103          	lb	sp,64(s2)
 176:	0100                	addi	s0,sp,128
 178:	04090503          	lb	a0,64(s2)
 17c:	0100                	addi	s0,sp,128
 17e:	04090103          	lb	sp,64(s2)
 182:	0100                	addi	s0,sp,128
 184:	04090103          	lb	sp,64(s2)
 188:	0100                	addi	s0,sp,128
 18a:	04090103          	lb	sp,64(s2)
 18e:	0100                	addi	s0,sp,128
 190:	04090203          	lb	tp,64(s2)
 194:	0100                	addi	s0,sp,128
 196:	04090203          	lb	tp,64(s2)
 19a:	0100                	addi	s0,sp,128
 19c:	04090103          	lb	sp,64(s2)
 1a0:	0100                	addi	s0,sp,128
 1a2:	04090103          	lb	sp,64(s2)
 1a6:	0100                	addi	s0,sp,128
 1a8:	04090103          	lb	sp,64(s2)
 1ac:	0100                	addi	s0,sp,128
 1ae:	04090403          	lb	s0,64(s2)
 1b2:	0100                	addi	s0,sp,128
 1b4:	04090103          	lb	sp,64(s2)
 1b8:	0100                	addi	s0,sp,128
 1ba:	04090103          	lb	sp,64(s2)
 1be:	0100                	addi	s0,sp,128
 1c0:	04090203          	lb	tp,64(s2)
 1c4:	0100                	addi	s0,sp,128
 1c6:	04090103          	lb	sp,64(s2)
 1ca:	0100                	addi	s0,sp,128
 1cc:	04090103          	lb	sp,64(s2)
 1d0:	0100                	addi	s0,sp,128
 1d2:	04090203          	lb	tp,64(s2)
 1d6:	0100                	addi	s0,sp,128
 1d8:	04090103          	lb	sp,64(s2)
 1dc:	0100                	addi	s0,sp,128
 1de:	04090203          	lb	tp,64(s2)
 1e2:	0100                	addi	s0,sp,128
 1e4:	04090103          	lb	sp,64(s2)
 1e8:	0100                	addi	s0,sp,128
 1ea:	04090103          	lb	sp,64(s2)
 1ee:	0100                	addi	s0,sp,128
 1f0:	04090103          	lb	sp,64(s2)
 1f4:	0100                	addi	s0,sp,128
 1f6:	0409                	addi	s0,s0,2
 1f8:	0000                	unimp
 1fa:	0101                	addi	sp,sp,0

Disassembly of section .debug_str:

00000000 <.debug_str>:
   0:	2e2e                	fld	ft8,200(sp)
   2:	2f2e2e2f          	0x2f2e2e2f
   6:	2e2e                	fld	ft8,200(sp)
   8:	2f2e2e2f          	0x2f2e2e2f
   c:	6972                	flw	fs2,28(sp)
   e:	2d766373          	csrrsi	t1,0x2d7,12
  12:	2f636367          	0x2f636367
  16:	696c                	flw	fa1,84(a0)
  18:	6762                	flw	fa4,24(sp)
  1a:	632f6363          	bltu	t5,s2,640 <register_fini-0xfa34>
  1e:	69666e6f          	jal	t3,666b4 <__global_pointer$+0x5462c>
  22:	69722f67          	0x69722f67
  26:	2f766373          	csrrsi	t1,0x2f7,12
  2a:	756d                	lui	a0,0xffffb
  2c:	646c                	flw	fa1,76(s0)
  2e:	3369                	jal	fffffdb8 <__global_pointer$+0xfffedd30>
  30:	532e                	lw	t1,232(sp)
  32:	2f00                	fld	fs0,24(a4)
  34:	6f68                	flw	fa0,92(a4)
  36:	656d                	lui	a0,0x1b
  38:	796d6a2f          	0x796d6a2f
  3c:	2f65                	jal	7f4 <register_fini-0xf880>
  3e:	6f74                	flw	fa3,92(a4)
  40:	2f736c6f          	jal	s8,36b36 <__global_pointer$+0x24aae>
  44:	6972                	flw	fs2,28(sp)
  46:	2d766373          	csrrsi	t1,0x2d7,12
  4a:	2d756e67          	0x2d756e67
  4e:	6f74                	flw	fa3,92(a4)
  50:	68636c6f          	jal	s8,366d6 <__global_pointer$+0x2464e>
  54:	6961                	lui	s2,0x18
  56:	2f6e                	fld	ft10,216(sp)
  58:	7562                	flw	fa0,56(sp)
  5a:	6c69                	lui	s8,0x1a
  5c:	2f64                	fld	fs1,216(a4)
  5e:	7562                	flw	fa0,56(sp)
  60:	6c69                	lui	s8,0x1a
  62:	2d64                	fld	fs1,216(a0)
  64:	2d636367          	0x2d636367
  68:	656e                	flw	fa0,216(sp)
  6a:	62696c77          	0x62696c77
  6e:	732d                	lui	t1,0xfffeb
  70:	6174                	flw	fa3,68(a0)
  72:	2f326567          	0x2f326567
  76:	6972                	flw	fs2,28(sp)
  78:	33766373          	csrrsi	t1,mhpmevent23,12
  7c:	2d32                	fld	fs10,264(sp)
  7e:	6e75                	lui	t3,0x1d
  80:	776f6e6b          	0x776f6e6b
  84:	2d6e                	fld	fs10,216(sp)
  86:	6c65                	lui	s8,0x19
  88:	2f66                	fld	ft10,88(sp)
  8a:	696c                	flw	fa1,84(a0)
  8c:	6762                	flw	fa4,24(sp)
  8e:	47006363          	bltu	zero,a6,4f4 <register_fini-0xfb80>
  92:	554e                	lw	a0,240(sp)
  94:	4120                	lw	s0,64(a0)
  96:	2e322053          	0x2e322053
  9a:	2e003233          	0x2e003233
  9e:	2f2e                	fld	ft10,200(sp)
  a0:	2e2e                	fld	ft8,200(sp)
  a2:	2f2e2e2f          	0x2f2e2e2f
  a6:	2e2e                	fld	ft8,200(sp)
  a8:	7369722f          	0x7369722f
  ac:	672d7663          	bgeu	s10,s2,718 <register_fini-0xf95c>
  b0:	6c2f6363          	bltu	t5,sp,776 <register_fini-0xf8fe>
  b4:	6269                	lui	tp,0x1a
  b6:	2f636367          	0x2f636367
  ba:	666e6f63          	bltu	t3,t1,738 <register_fini-0xf93c>
  be:	6769                	lui	a4,0x1a
  c0:	7369722f          	0x7369722f
  c4:	642f7663          	bgeu	t5,sp,710 <register_fini-0xf964>
  c8:	7669                	lui	a2,0xffffa
  ca:	532e                	lw	t1,232(sp)
	...
