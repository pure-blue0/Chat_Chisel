
32riscv-elf/ackermann.riscv:     file format elf32-littleriscv


Disassembly of section .text:

00010074 <register_fini>:
   10074:	000007b7          	lui	a5,0x0
   10078:	00078793          	mv	a5,a5
   1007c:	00078863          	beqz	a5,1008c <register_fini+0x18>
   10080:	00010537          	lui	a0,0x10
   10084:	68850513          	addi	a0,a0,1672 # 10688 <__libc_fini_array>
   10088:	65c0006f          	j	106e4 <atexit>
   1008c:	00008067          	ret

00010090 <_start>:
   10090:	00002197          	auipc	gp,0x2
   10094:	f7818193          	addi	gp,gp,-136 # 12008 <__global_pointer$>
   10098:	c3418513          	addi	a0,gp,-972 # 11c3c <_edata>
   1009c:	c5018613          	addi	a2,gp,-944 # 11c58 <__BSS_END__>
   100a0:	40a60633          	sub	a2,a2,a0
   100a4:	00000593          	li	a1,0
   100a8:	3e4000ef          	jal	ra,1048c <memset>
   100ac:	00000517          	auipc	a0,0x0
   100b0:	63850513          	addi	a0,a0,1592 # 106e4 <atexit>
   100b4:	00050863          	beqz	a0,100c4 <_start+0x34>
   100b8:	00000517          	auipc	a0,0x0
   100bc:	5d050513          	addi	a0,a0,1488 # 10688 <__libc_fini_array>
   100c0:	624000ef          	jal	ra,106e4 <atexit>
   100c4:	32c000ef          	jal	ra,103f0 <__libc_init_array>
   100c8:	00012503          	lw	a0,0(sp)
   100cc:	00410593          	addi	a1,sp,4
   100d0:	00000613          	li	a2,0
   100d4:	120000ef          	jal	ra,101f4 <main>
   100d8:	2e80006f          	j	103c0 <exit>

000100dc <__do_global_dtors_aux>:
   100dc:	c341c703          	lbu	a4,-972(gp) # 11c3c <_edata>
   100e0:	04071463          	bnez	a4,10128 <__do_global_dtors_aux+0x4c>
   100e4:	ff010113          	addi	sp,sp,-16
   100e8:	00812423          	sw	s0,8(sp)
   100ec:	00078413          	mv	s0,a5
   100f0:	000007b7          	lui	a5,0x0
   100f4:	00112623          	sw	ra,12(sp)
   100f8:	00078793          	mv	a5,a5
   100fc:	00078a63          	beqz	a5,10110 <__do_global_dtors_aux+0x34>
   10100:	00011537          	lui	a0,0x11
   10104:	7f450513          	addi	a0,a0,2036 # 117f4 <__FRAME_END__>
   10108:	00000097          	auipc	ra,0x0
   1010c:	000000e7          	jalr	zero # 0 <register_fini-0x10074>
   10110:	00100793          	li	a5,1
   10114:	00c12083          	lw	ra,12(sp)
   10118:	c2f18a23          	sb	a5,-972(gp) # 11c3c <_edata>
   1011c:	00812403          	lw	s0,8(sp)
   10120:	01010113          	addi	sp,sp,16
   10124:	00008067          	ret
   10128:	00008067          	ret

0001012c <frame_dummy>:
   1012c:	000007b7          	lui	a5,0x0
   10130:	00078793          	mv	a5,a5
   10134:	00078c63          	beqz	a5,1014c <frame_dummy+0x20>
   10138:	00011537          	lui	a0,0x11
   1013c:	c3818593          	addi	a1,gp,-968 # 11c40 <object.5495>
   10140:	7f450513          	addi	a0,a0,2036 # 117f4 <__FRAME_END__>
   10144:	00000317          	auipc	t1,0x0
   10148:	00000067          	jr	zero # 0 <register_fini-0x10074>
   1014c:	00008067          	ret

00010150 <ackermann>:
   10150:	fe010113          	addi	sp,sp,-32
   10154:	00112e23          	sw	ra,28(sp)
   10158:	00812c23          	sw	s0,24(sp)
   1015c:	00912a23          	sw	s1,20(sp)
   10160:	02010413          	addi	s0,sp,32
   10164:	fea42623          	sw	a0,-20(s0)
   10168:	feb42423          	sw	a1,-24(s0)
   1016c:	fec42783          	lw	a5,-20(s0)
   10170:	00079863          	bnez	a5,10180 <ackermann+0x30>
   10174:	fe842783          	lw	a5,-24(s0)
   10178:	00178793          	addi	a5,a5,1 # 1 <register_fini-0x10073>
   1017c:	0600006f          	j	101dc <ackermann+0x8c>
   10180:	fec42783          	lw	a5,-20(s0)
   10184:	02f05463          	blez	a5,101ac <ackermann+0x5c>
   10188:	fe842783          	lw	a5,-24(s0)
   1018c:	02079063          	bnez	a5,101ac <ackermann+0x5c>
   10190:	fec42783          	lw	a5,-20(s0)
   10194:	fff78793          	addi	a5,a5,-1
   10198:	00100593          	li	a1,1
   1019c:	00078513          	mv	a0,a5
   101a0:	fb1ff0ef          	jal	ra,10150 <ackermann>
   101a4:	00050793          	mv	a5,a0
   101a8:	0340006f          	j	101dc <ackermann+0x8c>
   101ac:	fec42783          	lw	a5,-20(s0)
   101b0:	fff78493          	addi	s1,a5,-1
   101b4:	fe842783          	lw	a5,-24(s0)
   101b8:	fff78793          	addi	a5,a5,-1
   101bc:	00078593          	mv	a1,a5
   101c0:	fec42503          	lw	a0,-20(s0)
   101c4:	f8dff0ef          	jal	ra,10150 <ackermann>
   101c8:	00050793          	mv	a5,a0
   101cc:	00078593          	mv	a1,a5
   101d0:	00048513          	mv	a0,s1
   101d4:	f7dff0ef          	jal	ra,10150 <ackermann>
   101d8:	00050793          	mv	a5,a0
   101dc:	00078513          	mv	a0,a5
   101e0:	01c12083          	lw	ra,28(sp)
   101e4:	01812403          	lw	s0,24(sp)
   101e8:	01412483          	lw	s1,20(sp)
   101ec:	02010113          	addi	sp,sp,32
   101f0:	00008067          	ret

000101f4 <main>:
   101f4:	fe010113          	addi	sp,sp,-32
   101f8:	00112e23          	sw	ra,28(sp)
   101fc:	00812c23          	sw	s0,24(sp)
   10200:	02010413          	addi	s0,sp,32
   10204:	fe042623          	sw	zero,-20(s0)
   10208:	0840006f          	j	1028c <main+0x98>
   1020c:	fe042423          	sw	zero,-24(s0)
   10210:	0640006f          	j	10274 <main+0x80>
   10214:	fe842583          	lw	a1,-24(s0)
   10218:	fec42503          	lw	a0,-20(s0)
   1021c:	f35ff0ef          	jal	ra,10150 <ackermann>
   10220:	fea42223          	sw	a0,-28(s0)
   10224:	000107b7          	lui	a5,0x10
   10228:	7dc78513          	addi	a0,a5,2012 # 107dc <__errno+0x8>
   1022c:	0b0000ef          	jal	ra,102dc <print_s>
   10230:	fec42503          	lw	a0,-20(s0)
   10234:	080000ef          	jal	ra,102b4 <print_d>
   10238:	000107b7          	lui	a5,0x10
   1023c:	7e878513          	addi	a0,a5,2024 # 107e8 <__errno+0x14>
   10240:	09c000ef          	jal	ra,102dc <print_s>
   10244:	fe842503          	lw	a0,-24(s0)
   10248:	06c000ef          	jal	ra,102b4 <print_d>
   1024c:	000107b7          	lui	a5,0x10
   10250:	7ec78513          	addi	a0,a5,2028 # 107ec <__errno+0x18>
   10254:	088000ef          	jal	ra,102dc <print_s>
   10258:	fe442503          	lw	a0,-28(s0)
   1025c:	058000ef          	jal	ra,102b4 <print_d>
   10260:	00a00513          	li	a0,10
   10264:	0a0000ef          	jal	ra,10304 <print_c>
   10268:	fe842783          	lw	a5,-24(s0)
   1026c:	00178793          	addi	a5,a5,1
   10270:	fef42423          	sw	a5,-24(s0)
   10274:	fe842703          	lw	a4,-24(s0)
   10278:	00400793          	li	a5,4
   1027c:	f8e7dce3          	bge	a5,a4,10214 <main+0x20>
   10280:	fec42783          	lw	a5,-20(s0)
   10284:	00178793          	addi	a5,a5,1
   10288:	fef42623          	sw	a5,-20(s0)
   1028c:	fec42703          	lw	a4,-20(s0)
   10290:	00300793          	li	a5,3
   10294:	f6e7dce3          	bge	a5,a4,1020c <main+0x18>
   10298:	098000ef          	jal	ra,10330 <exit_proc>
   1029c:	00000793          	li	a5,0
   102a0:	00078513          	mv	a0,a5
   102a4:	01c12083          	lw	ra,28(sp)
   102a8:	01812403          	lw	s0,24(sp)
   102ac:	02010113          	addi	sp,sp,32
   102b0:	00008067          	ret

000102b4 <print_d>:
   102b4:	fe010113          	addi	sp,sp,-32
   102b8:	00812e23          	sw	s0,28(sp)
   102bc:	02010413          	addi	s0,sp,32
   102c0:	fea42623          	sw	a0,-20(s0)
   102c4:	00200893          	li	a7,2
   102c8:	00000073          	ecall
   102cc:	00000013          	nop
   102d0:	01c12403          	lw	s0,28(sp)
   102d4:	02010113          	addi	sp,sp,32
   102d8:	00008067          	ret

000102dc <print_s>:
   102dc:	fe010113          	addi	sp,sp,-32
   102e0:	00812e23          	sw	s0,28(sp)
   102e4:	02010413          	addi	s0,sp,32
   102e8:	fea42623          	sw	a0,-20(s0)
   102ec:	00000893          	li	a7,0
   102f0:	00000073          	ecall
   102f4:	00000013          	nop
   102f8:	01c12403          	lw	s0,28(sp)
   102fc:	02010113          	addi	sp,sp,32
   10300:	00008067          	ret

00010304 <print_c>:
   10304:	fe010113          	addi	sp,sp,-32
   10308:	00812e23          	sw	s0,28(sp)
   1030c:	02010413          	addi	s0,sp,32
   10310:	00050793          	mv	a5,a0
   10314:	fef407a3          	sb	a5,-17(s0)
   10318:	00100893          	li	a7,1
   1031c:	00000073          	ecall
   10320:	00000013          	nop
   10324:	01c12403          	lw	s0,28(sp)
   10328:	02010113          	addi	sp,sp,32
   1032c:	00008067          	ret

00010330 <exit_proc>:
   10330:	ff010113          	addi	sp,sp,-16
   10334:	00812623          	sw	s0,12(sp)
   10338:	01010413          	addi	s0,sp,16
   1033c:	00300893          	li	a7,3
   10340:	00000073          	ecall
   10344:	00000013          	nop
   10348:	00c12403          	lw	s0,12(sp)
   1034c:	01010113          	addi	sp,sp,16
   10350:	00008067          	ret

00010354 <read_char>:
   10354:	fe010113          	addi	sp,sp,-32
   10358:	00812e23          	sw	s0,28(sp)
   1035c:	02010413          	addi	s0,sp,32
   10360:	00400893          	li	a7,4
   10364:	00000073          	ecall
   10368:	00050793          	mv	a5,a0
   1036c:	fef407a3          	sb	a5,-17(s0)
   10370:	fef44783          	lbu	a5,-17(s0)
   10374:	00078513          	mv	a0,a5
   10378:	01c12403          	lw	s0,28(sp)
   1037c:	02010113          	addi	sp,sp,32
   10380:	00008067          	ret

00010384 <read_num>:
   10384:	fe010113          	addi	sp,sp,-32
   10388:	00812e23          	sw	s0,28(sp)
   1038c:	02010413          	addi	s0,sp,32
   10390:	00500893          	li	a7,5
   10394:	00000073          	ecall
   10398:	00050713          	mv	a4,a0
   1039c:	fee42423          	sw	a4,-24(s0)
   103a0:	fef42623          	sw	a5,-20(s0)
   103a4:	fe842703          	lw	a4,-24(s0)
   103a8:	fec42783          	lw	a5,-20(s0)
   103ac:	00070513          	mv	a0,a4
   103b0:	00078593          	mv	a1,a5
   103b4:	01c12403          	lw	s0,28(sp)
   103b8:	02010113          	addi	sp,sp,32
   103bc:	00008067          	ret

000103c0 <exit>:
   103c0:	ff010113          	addi	sp,sp,-16
   103c4:	00000593          	li	a1,0
   103c8:	00812423          	sw	s0,8(sp)
   103cc:	00112623          	sw	ra,12(sp)
   103d0:	00050413          	mv	s0,a0
   103d4:	194000ef          	jal	ra,10568 <__call_exitprocs>
   103d8:	c281a503          	lw	a0,-984(gp) # 11c30 <_global_impure_ptr>
   103dc:	03c52783          	lw	a5,60(a0)
   103e0:	00078463          	beqz	a5,103e8 <exit+0x28>
   103e4:	000780e7          	jalr	a5
   103e8:	00040513          	mv	a0,s0
   103ec:	3a4000ef          	jal	ra,10790 <_exit>

000103f0 <__libc_init_array>:
   103f0:	ff010113          	addi	sp,sp,-16
   103f4:	00812423          	sw	s0,8(sp)
   103f8:	01212023          	sw	s2,0(sp)
   103fc:	00011437          	lui	s0,0x11
   10400:	00011937          	lui	s2,0x11
   10404:	7f840793          	addi	a5,s0,2040 # 117f8 <__init_array_start>
   10408:	7f890913          	addi	s2,s2,2040 # 117f8 <__init_array_start>
   1040c:	40f90933          	sub	s2,s2,a5
   10410:	00112623          	sw	ra,12(sp)
   10414:	00912223          	sw	s1,4(sp)
   10418:	40295913          	srai	s2,s2,0x2
   1041c:	02090063          	beqz	s2,1043c <__libc_init_array+0x4c>
   10420:	7f840413          	addi	s0,s0,2040
   10424:	00000493          	li	s1,0
   10428:	00042783          	lw	a5,0(s0)
   1042c:	00148493          	addi	s1,s1,1
   10430:	00440413          	addi	s0,s0,4
   10434:	000780e7          	jalr	a5
   10438:	fe9918e3          	bne	s2,s1,10428 <__libc_init_array+0x38>
   1043c:	00011437          	lui	s0,0x11
   10440:	00012937          	lui	s2,0x12
   10444:	7f840793          	addi	a5,s0,2040 # 117f8 <__init_array_start>
   10448:	80090913          	addi	s2,s2,-2048 # 11800 <__init_array_end>
   1044c:	40f90933          	sub	s2,s2,a5
   10450:	40295913          	srai	s2,s2,0x2
   10454:	02090063          	beqz	s2,10474 <__libc_init_array+0x84>
   10458:	7f840413          	addi	s0,s0,2040
   1045c:	00000493          	li	s1,0
   10460:	00042783          	lw	a5,0(s0)
   10464:	00148493          	addi	s1,s1,1
   10468:	00440413          	addi	s0,s0,4
   1046c:	000780e7          	jalr	a5
   10470:	fe9918e3          	bne	s2,s1,10460 <__libc_init_array+0x70>
   10474:	00c12083          	lw	ra,12(sp)
   10478:	00812403          	lw	s0,8(sp)
   1047c:	00412483          	lw	s1,4(sp)
   10480:	00012903          	lw	s2,0(sp)
   10484:	01010113          	addi	sp,sp,16
   10488:	00008067          	ret

0001048c <memset>:
   1048c:	00f00313          	li	t1,15
   10490:	00050713          	mv	a4,a0
   10494:	02c37e63          	bgeu	t1,a2,104d0 <memset+0x44>
   10498:	00f77793          	andi	a5,a4,15
   1049c:	0a079063          	bnez	a5,1053c <memset+0xb0>
   104a0:	08059263          	bnez	a1,10524 <memset+0x98>
   104a4:	ff067693          	andi	a3,a2,-16
   104a8:	00f67613          	andi	a2,a2,15
   104ac:	00e686b3          	add	a3,a3,a4
   104b0:	00b72023          	sw	a1,0(a4)
   104b4:	00b72223          	sw	a1,4(a4)
   104b8:	00b72423          	sw	a1,8(a4)
   104bc:	00b72623          	sw	a1,12(a4)
   104c0:	01070713          	addi	a4,a4,16
   104c4:	fed766e3          	bltu	a4,a3,104b0 <memset+0x24>
   104c8:	00061463          	bnez	a2,104d0 <memset+0x44>
   104cc:	00008067          	ret
   104d0:	40c306b3          	sub	a3,t1,a2
   104d4:	00269693          	slli	a3,a3,0x2
   104d8:	00000297          	auipc	t0,0x0
   104dc:	005686b3          	add	a3,a3,t0
   104e0:	00c68067          	jr	12(a3)
   104e4:	00b70723          	sb	a1,14(a4)
   104e8:	00b706a3          	sb	a1,13(a4)
   104ec:	00b70623          	sb	a1,12(a4)
   104f0:	00b705a3          	sb	a1,11(a4)
   104f4:	00b70523          	sb	a1,10(a4)
   104f8:	00b704a3          	sb	a1,9(a4)
   104fc:	00b70423          	sb	a1,8(a4)
   10500:	00b703a3          	sb	a1,7(a4)
   10504:	00b70323          	sb	a1,6(a4)
   10508:	00b702a3          	sb	a1,5(a4)
   1050c:	00b70223          	sb	a1,4(a4)
   10510:	00b701a3          	sb	a1,3(a4)
   10514:	00b70123          	sb	a1,2(a4)
   10518:	00b700a3          	sb	a1,1(a4)
   1051c:	00b70023          	sb	a1,0(a4)
   10520:	00008067          	ret
   10524:	0ff5f593          	andi	a1,a1,255
   10528:	00859693          	slli	a3,a1,0x8
   1052c:	00d5e5b3          	or	a1,a1,a3
   10530:	01059693          	slli	a3,a1,0x10
   10534:	00d5e5b3          	or	a1,a1,a3
   10538:	f6dff06f          	j	104a4 <memset+0x18>
   1053c:	00279693          	slli	a3,a5,0x2
   10540:	00000297          	auipc	t0,0x0
   10544:	005686b3          	add	a3,a3,t0
   10548:	00008293          	mv	t0,ra
   1054c:	fa0680e7          	jalr	-96(a3)
   10550:	00028093          	mv	ra,t0
   10554:	ff078793          	addi	a5,a5,-16
   10558:	40f70733          	sub	a4,a4,a5
   1055c:	00f60633          	add	a2,a2,a5
   10560:	f6c378e3          	bgeu	t1,a2,104d0 <memset+0x44>
   10564:	f3dff06f          	j	104a0 <memset+0x14>

00010568 <__call_exitprocs>:
   10568:	fd010113          	addi	sp,sp,-48
   1056c:	01412c23          	sw	s4,24(sp)
   10570:	c281aa03          	lw	s4,-984(gp) # 11c30 <_global_impure_ptr>
   10574:	03212023          	sw	s2,32(sp)
   10578:	02112623          	sw	ra,44(sp)
   1057c:	148a2903          	lw	s2,328(s4)
   10580:	02812423          	sw	s0,40(sp)
   10584:	02912223          	sw	s1,36(sp)
   10588:	01312e23          	sw	s3,28(sp)
   1058c:	01512a23          	sw	s5,20(sp)
   10590:	01612823          	sw	s6,16(sp)
   10594:	01712623          	sw	s7,12(sp)
   10598:	01812423          	sw	s8,8(sp)
   1059c:	04090063          	beqz	s2,105dc <__call_exitprocs+0x74>
   105a0:	00050b13          	mv	s6,a0
   105a4:	00058b93          	mv	s7,a1
   105a8:	00100a93          	li	s5,1
   105ac:	fff00993          	li	s3,-1
   105b0:	00492483          	lw	s1,4(s2)
   105b4:	fff48413          	addi	s0,s1,-1
   105b8:	02044263          	bltz	s0,105dc <__call_exitprocs+0x74>
   105bc:	00249493          	slli	s1,s1,0x2
   105c0:	009904b3          	add	s1,s2,s1
   105c4:	040b8463          	beqz	s7,1060c <__call_exitprocs+0xa4>
   105c8:	1044a783          	lw	a5,260(s1)
   105cc:	05778063          	beq	a5,s7,1060c <__call_exitprocs+0xa4>
   105d0:	fff40413          	addi	s0,s0,-1
   105d4:	ffc48493          	addi	s1,s1,-4
   105d8:	ff3416e3          	bne	s0,s3,105c4 <__call_exitprocs+0x5c>
   105dc:	02c12083          	lw	ra,44(sp)
   105e0:	02812403          	lw	s0,40(sp)
   105e4:	02412483          	lw	s1,36(sp)
   105e8:	02012903          	lw	s2,32(sp)
   105ec:	01c12983          	lw	s3,28(sp)
   105f0:	01812a03          	lw	s4,24(sp)
   105f4:	01412a83          	lw	s5,20(sp)
   105f8:	01012b03          	lw	s6,16(sp)
   105fc:	00c12b83          	lw	s7,12(sp)
   10600:	00812c03          	lw	s8,8(sp)
   10604:	03010113          	addi	sp,sp,48
   10608:	00008067          	ret
   1060c:	00492783          	lw	a5,4(s2)
   10610:	0044a683          	lw	a3,4(s1)
   10614:	fff78793          	addi	a5,a5,-1
   10618:	04878e63          	beq	a5,s0,10674 <__call_exitprocs+0x10c>
   1061c:	0004a223          	sw	zero,4(s1)
   10620:	fa0688e3          	beqz	a3,105d0 <__call_exitprocs+0x68>
   10624:	18892783          	lw	a5,392(s2)
   10628:	008a9733          	sll	a4,s5,s0
   1062c:	00492c03          	lw	s8,4(s2)
   10630:	00f777b3          	and	a5,a4,a5
   10634:	02079263          	bnez	a5,10658 <__call_exitprocs+0xf0>
   10638:	000680e7          	jalr	a3
   1063c:	00492703          	lw	a4,4(s2)
   10640:	148a2783          	lw	a5,328(s4)
   10644:	01871463          	bne	a4,s8,1064c <__call_exitprocs+0xe4>
   10648:	f8f904e3          	beq	s2,a5,105d0 <__call_exitprocs+0x68>
   1064c:	f80788e3          	beqz	a5,105dc <__call_exitprocs+0x74>
   10650:	00078913          	mv	s2,a5
   10654:	f5dff06f          	j	105b0 <__call_exitprocs+0x48>
   10658:	18c92783          	lw	a5,396(s2)
   1065c:	0844a583          	lw	a1,132(s1)
   10660:	00f77733          	and	a4,a4,a5
   10664:	00071c63          	bnez	a4,1067c <__call_exitprocs+0x114>
   10668:	000b0513          	mv	a0,s6
   1066c:	000680e7          	jalr	a3
   10670:	fcdff06f          	j	1063c <__call_exitprocs+0xd4>
   10674:	00892223          	sw	s0,4(s2)
   10678:	fa9ff06f          	j	10620 <__call_exitprocs+0xb8>
   1067c:	00058513          	mv	a0,a1
   10680:	000680e7          	jalr	a3
   10684:	fb9ff06f          	j	1063c <__call_exitprocs+0xd4>

00010688 <__libc_fini_array>:
   10688:	ff010113          	addi	sp,sp,-16
   1068c:	00812423          	sw	s0,8(sp)
   10690:	000127b7          	lui	a5,0x12
   10694:	00012437          	lui	s0,0x12
   10698:	80040413          	addi	s0,s0,-2048 # 11800 <__init_array_end>
   1069c:	80478793          	addi	a5,a5,-2044 # 11804 <__fini_array_end>
   106a0:	408787b3          	sub	a5,a5,s0
   106a4:	00912223          	sw	s1,4(sp)
   106a8:	00112623          	sw	ra,12(sp)
   106ac:	4027d493          	srai	s1,a5,0x2
   106b0:	02048063          	beqz	s1,106d0 <__libc_fini_array+0x48>
   106b4:	ffc78793          	addi	a5,a5,-4
   106b8:	00878433          	add	s0,a5,s0
   106bc:	00042783          	lw	a5,0(s0)
   106c0:	fff48493          	addi	s1,s1,-1
   106c4:	ffc40413          	addi	s0,s0,-4
   106c8:	000780e7          	jalr	a5
   106cc:	fe0498e3          	bnez	s1,106bc <__libc_fini_array+0x34>
   106d0:	00c12083          	lw	ra,12(sp)
   106d4:	00812403          	lw	s0,8(sp)
   106d8:	00412483          	lw	s1,4(sp)
   106dc:	01010113          	addi	sp,sp,16
   106e0:	00008067          	ret

000106e4 <atexit>:
   106e4:	00050593          	mv	a1,a0
   106e8:	00000693          	li	a3,0
   106ec:	00000613          	li	a2,0
   106f0:	00000513          	li	a0,0
   106f4:	0040006f          	j	106f8 <__register_exitproc>

000106f8 <__register_exitproc>:
   106f8:	c281a703          	lw	a4,-984(gp) # 11c30 <_global_impure_ptr>
   106fc:	14872783          	lw	a5,328(a4)
   10700:	04078c63          	beqz	a5,10758 <__register_exitproc+0x60>
   10704:	0047a703          	lw	a4,4(a5)
   10708:	01f00813          	li	a6,31
   1070c:	06e84e63          	blt	a6,a4,10788 <__register_exitproc+0x90>
   10710:	00271813          	slli	a6,a4,0x2
   10714:	02050663          	beqz	a0,10740 <__register_exitproc+0x48>
   10718:	01078333          	add	t1,a5,a6
   1071c:	08c32423          	sw	a2,136(t1) # 101cc <ackermann+0x7c>
   10720:	1887a883          	lw	a7,392(a5)
   10724:	00100613          	li	a2,1
   10728:	00e61633          	sll	a2,a2,a4
   1072c:	00c8e8b3          	or	a7,a7,a2
   10730:	1917a423          	sw	a7,392(a5)
   10734:	10d32423          	sw	a3,264(t1)
   10738:	00200693          	li	a3,2
   1073c:	02d50463          	beq	a0,a3,10764 <__register_exitproc+0x6c>
   10740:	00170713          	addi	a4,a4,1
   10744:	00e7a223          	sw	a4,4(a5)
   10748:	010787b3          	add	a5,a5,a6
   1074c:	00b7a423          	sw	a1,8(a5)
   10750:	00000513          	li	a0,0
   10754:	00008067          	ret
   10758:	14c70793          	addi	a5,a4,332
   1075c:	14f72423          	sw	a5,328(a4)
   10760:	fa5ff06f          	j	10704 <__register_exitproc+0xc>
   10764:	18c7a683          	lw	a3,396(a5)
   10768:	00170713          	addi	a4,a4,1
   1076c:	00e7a223          	sw	a4,4(a5)
   10770:	00c6e633          	or	a2,a3,a2
   10774:	18c7a623          	sw	a2,396(a5)
   10778:	010787b3          	add	a5,a5,a6
   1077c:	00b7a423          	sw	a1,8(a5)
   10780:	00000513          	li	a0,0
   10784:	00008067          	ret
   10788:	fff00513          	li	a0,-1
   1078c:	00008067          	ret

00010790 <_exit>:
   10790:	00000593          	li	a1,0
   10794:	00000613          	li	a2,0
   10798:	00000693          	li	a3,0
   1079c:	00000713          	li	a4,0
   107a0:	00000793          	li	a5,0
   107a4:	05d00893          	li	a7,93
   107a8:	00000073          	ecall
   107ac:	00054463          	bltz	a0,107b4 <_exit+0x24>
   107b0:	0000006f          	j	107b0 <_exit+0x20>
   107b4:	ff010113          	addi	sp,sp,-16
   107b8:	00812423          	sw	s0,8(sp)
   107bc:	00050413          	mv	s0,a0
   107c0:	00112623          	sw	ra,12(sp)
   107c4:	40800433          	neg	s0,s0
   107c8:	00c000ef          	jal	ra,107d4 <__errno>
   107cc:	00852023          	sw	s0,0(a0)
   107d0:	0000006f          	j	107d0 <_exit+0x40>

000107d4 <__errno>:
   107d4:	c301a503          	lw	a0,-976(gp) # 11c38 <_impure_ptr>
   107d8:	00008067          	ret

Disassembly of section .rodata:

000107dc <.rodata>:
   107dc:	6341                	lui	t1,0x10
   107de:	6d72656b          	0x6d72656b
   107e2:	6e61                	lui	t3,0x18
   107e4:	286e                	fld	fa6,216(sp)
   107e6:	0000                	unimp
   107e8:	002c                	addi	a1,sp,8
   107ea:	0000                	unimp
   107ec:	2029                	jal	107f6 <__errno+0x22>
   107ee:	203d                	jal	1081c <__errno+0x48>
	...

Disassembly of section .eh_frame:

000117f4 <__FRAME_END__>:
   117f4:	0000                	unimp
	...

Disassembly of section .init_array:

000117f8 <__init_array_start>:
   117f8:	0074                	addi	a3,sp,12
   117fa:	0001                	nop

000117fc <__frame_dummy_init_array_entry>:
   117fc:	012c                	addi	a1,sp,136
   117fe:	0001                	nop

Disassembly of section .fini_array:

00011800 <__do_global_dtors_aux_fini_array_entry>:
   11800:	00dc                	addi	a5,sp,68
   11802:	0001                	nop

Disassembly of section .data:

00011808 <__DATA_BEGIN__>:
   11808:	0000                	unimp
   1180a:	0000                	unimp
   1180c:	1af4                	addi	a3,sp,380
   1180e:	0001                	nop
   11810:	1b5c                	addi	a5,sp,436
   11812:	0001                	nop
   11814:	1bc4                	addi	s1,sp,500
   11816:	0001                	nop
	...
   118b0:	0001                	nop
   118b2:	0000                	unimp
   118b4:	0000                	unimp
   118b6:	0000                	unimp
   118b8:	330e                	fld	ft6,224(sp)
   118ba:	abcd                	j	11eac <__BSS_END__+0x254>
   118bc:	1234                	addi	a3,sp,296
   118be:	e66d                	bnez	a2,119a8 <__DATA_BEGIN__+0x1a0>
   118c0:	deec                	sw	a1,124(a3)
   118c2:	0005                	c.nop	1
   118c4:	0000000b          	0xb
	...

Disassembly of section .sdata:

00011c30 <_global_impure_ptr>:
   11c30:	1808                	addi	a0,sp,48
   11c32:	0001                	nop

00011c34 <__dso_handle>:
   11c34:	0000                	unimp
	...

00011c38 <_impure_ptr>:
   11c38:	1808                	addi	a0,sp,48
   11c3a:	0001                	nop

Disassembly of section .bss:

00011c3c <__bss_start>:
   11c3c:	0000                	unimp
	...

00011c40 <object.5495>:
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
