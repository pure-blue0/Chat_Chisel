
32riscv-elf/add.riscv:     file format elf32-littleriscv


Disassembly of section .text:

00010074 <register_fini>:
   10074:	000007b7          	lui	a5,0x0
   10078:	00078793          	mv	a5,a5
   1007c:	00078863          	beqz	a5,1008c <register_fini+0x18>
   10080:	00010537          	lui	a0,0x10
   10084:	58050513          	addi	a0,a0,1408 # 10580 <__libc_fini_array>
   10088:	5540006f          	j	105dc <atexit>
   1008c:	00008067          	ret

00010090 <_start>:
   10090:	00002197          	auipc	gp,0x2
   10094:	e6018193          	addi	gp,gp,-416 # 11ef0 <__global_pointer$>
   10098:	c3418513          	addi	a0,gp,-972 # 11b24 <_edata>
   1009c:	c5018613          	addi	a2,gp,-944 # 11b40 <__BSS_END__>
   100a0:	40a60633          	sub	a2,a2,a0
   100a4:	00000593          	li	a1,0
   100a8:	2dc000ef          	jal	ra,10384 <memset>
   100ac:	00000517          	auipc	a0,0x0
   100b0:	53050513          	addi	a0,a0,1328 # 105dc <atexit>
   100b4:	00050863          	beqz	a0,100c4 <_start+0x34>
   100b8:	00000517          	auipc	a0,0x0
   100bc:	4c850513          	addi	a0,a0,1224 # 10580 <__libc_fini_array>
   100c0:	51c000ef          	jal	ra,105dc <atexit>
   100c4:	224000ef          	jal	ra,102e8 <__libc_init_array>
   100c8:	00012503          	lw	a0,0(sp)
   100cc:	00410593          	addi	a1,sp,4
   100d0:	00000613          	li	a2,0
   100d4:	07c000ef          	jal	ra,10150 <main>
   100d8:	1e00006f          	j	102b8 <exit>

000100dc <__do_global_dtors_aux>:
   100dc:	c341c703          	lbu	a4,-972(gp) # 11b24 <_edata>
   100e0:	04071463          	bnez	a4,10128 <__do_global_dtors_aux+0x4c>
   100e4:	ff010113          	addi	sp,sp,-16
   100e8:	00812423          	sw	s0,8(sp)
   100ec:	00078413          	mv	s0,a5
   100f0:	000007b7          	lui	a5,0x0
   100f4:	00112623          	sw	ra,12(sp)
   100f8:	00078793          	mv	a5,a5
   100fc:	00078a63          	beqz	a5,10110 <__do_global_dtors_aux+0x34>
   10100:	00011537          	lui	a0,0x11
   10104:	6e050513          	addi	a0,a0,1760 # 116e0 <__FRAME_END__>
   10108:	00000097          	auipc	ra,0x0
   1010c:	000000e7          	jalr	zero # 0 <register_fini-0x10074>
   10110:	00100793          	li	a5,1
   10114:	00c12083          	lw	ra,12(sp)
   10118:	c2f18a23          	sb	a5,-972(gp) # 11b24 <_edata>
   1011c:	00812403          	lw	s0,8(sp)
   10120:	01010113          	addi	sp,sp,16
   10124:	00008067          	ret
   10128:	00008067          	ret

0001012c <frame_dummy>:
   1012c:	000007b7          	lui	a5,0x0
   10130:	00078793          	mv	a5,a5
   10134:	00078c63          	beqz	a5,1014c <frame_dummy+0x20>
   10138:	00011537          	lui	a0,0x11
   1013c:	c3818593          	addi	a1,gp,-968 # 11b28 <object.5495>
   10140:	6e050513          	addi	a0,a0,1760 # 116e0 <__FRAME_END__>
   10144:	00000317          	auipc	t1,0x0
   10148:	00000067          	jr	zero # 0 <register_fini-0x10074>
   1014c:	00008067          	ret

00010150 <main>:
   10150:	fe010113          	addi	sp,sp,-32
   10154:	00112e23          	sw	ra,28(sp)
   10158:	00812c23          	sw	s0,24(sp)
   1015c:	02010413          	addi	s0,sp,32
   10160:	00200793          	li	a5,2
   10164:	fef42623          	sw	a5,-20(s0)
   10168:	00300793          	li	a5,3
   1016c:	fef42423          	sw	a5,-24(s0)
   10170:	fec42703          	lw	a4,-20(s0)
   10174:	fe842783          	lw	a5,-24(s0)
   10178:	00f707b3          	add	a5,a4,a5
   1017c:	fef42223          	sw	a5,-28(s0)
   10180:	000107b7          	lui	a5,0x10
   10184:	6d478513          	addi	a0,a5,1748 # 106d4 <__errno+0x8>
   10188:	04c000ef          	jal	ra,101d4 <print_s>
   1018c:	fe442503          	lw	a0,-28(s0)
   10190:	01c000ef          	jal	ra,101ac <print_d>
   10194:	00000793          	li	a5,0
   10198:	00078513          	mv	a0,a5
   1019c:	01c12083          	lw	ra,28(sp)
   101a0:	01812403          	lw	s0,24(sp)
   101a4:	02010113          	addi	sp,sp,32
   101a8:	00008067          	ret

000101ac <print_d>:
   101ac:	fe010113          	addi	sp,sp,-32
   101b0:	00812e23          	sw	s0,28(sp)
   101b4:	02010413          	addi	s0,sp,32
   101b8:	fea42623          	sw	a0,-20(s0)
   101bc:	00200893          	li	a7,2
   101c0:	00000073          	ecall
   101c4:	00000013          	nop
   101c8:	01c12403          	lw	s0,28(sp)
   101cc:	02010113          	addi	sp,sp,32
   101d0:	00008067          	ret

000101d4 <print_s>:
   101d4:	fe010113          	addi	sp,sp,-32
   101d8:	00812e23          	sw	s0,28(sp)
   101dc:	02010413          	addi	s0,sp,32
   101e0:	fea42623          	sw	a0,-20(s0)
   101e4:	00000893          	li	a7,0
   101e8:	00000073          	ecall
   101ec:	00000013          	nop
   101f0:	01c12403          	lw	s0,28(sp)
   101f4:	02010113          	addi	sp,sp,32
   101f8:	00008067          	ret

000101fc <print_c>:
   101fc:	fe010113          	addi	sp,sp,-32
   10200:	00812e23          	sw	s0,28(sp)
   10204:	02010413          	addi	s0,sp,32
   10208:	00050793          	mv	a5,a0
   1020c:	fef407a3          	sb	a5,-17(s0)
   10210:	00100893          	li	a7,1
   10214:	00000073          	ecall
   10218:	00000013          	nop
   1021c:	01c12403          	lw	s0,28(sp)
   10220:	02010113          	addi	sp,sp,32
   10224:	00008067          	ret

00010228 <exit_proc>:
   10228:	ff010113          	addi	sp,sp,-16
   1022c:	00812623          	sw	s0,12(sp)
   10230:	01010413          	addi	s0,sp,16
   10234:	00300893          	li	a7,3
   10238:	00000073          	ecall
   1023c:	00000013          	nop
   10240:	00c12403          	lw	s0,12(sp)
   10244:	01010113          	addi	sp,sp,16
   10248:	00008067          	ret

0001024c <read_char>:
   1024c:	fe010113          	addi	sp,sp,-32
   10250:	00812e23          	sw	s0,28(sp)
   10254:	02010413          	addi	s0,sp,32
   10258:	00400893          	li	a7,4
   1025c:	00000073          	ecall
   10260:	00050793          	mv	a5,a0
   10264:	fef407a3          	sb	a5,-17(s0)
   10268:	fef44783          	lbu	a5,-17(s0)
   1026c:	00078513          	mv	a0,a5
   10270:	01c12403          	lw	s0,28(sp)
   10274:	02010113          	addi	sp,sp,32
   10278:	00008067          	ret

0001027c <read_num>:
   1027c:	fe010113          	addi	sp,sp,-32
   10280:	00812e23          	sw	s0,28(sp)
   10284:	02010413          	addi	s0,sp,32
   10288:	00500893          	li	a7,5
   1028c:	00000073          	ecall
   10290:	00050713          	mv	a4,a0
   10294:	fee42423          	sw	a4,-24(s0)
   10298:	fef42623          	sw	a5,-20(s0)
   1029c:	fe842703          	lw	a4,-24(s0)
   102a0:	fec42783          	lw	a5,-20(s0)
   102a4:	00070513          	mv	a0,a4
   102a8:	00078593          	mv	a1,a5
   102ac:	01c12403          	lw	s0,28(sp)
   102b0:	02010113          	addi	sp,sp,32
   102b4:	00008067          	ret

000102b8 <exit>:
   102b8:	ff010113          	addi	sp,sp,-16
   102bc:	00000593          	li	a1,0
   102c0:	00812423          	sw	s0,8(sp)
   102c4:	00112623          	sw	ra,12(sp)
   102c8:	00050413          	mv	s0,a0
   102cc:	194000ef          	jal	ra,10460 <__call_exitprocs>
   102d0:	c281a503          	lw	a0,-984(gp) # 11b18 <_global_impure_ptr>
   102d4:	03c52783          	lw	a5,60(a0)
   102d8:	00078463          	beqz	a5,102e0 <exit+0x28>
   102dc:	000780e7          	jalr	a5
   102e0:	00040513          	mv	a0,s0
   102e4:	3a4000ef          	jal	ra,10688 <_exit>

000102e8 <__libc_init_array>:
   102e8:	ff010113          	addi	sp,sp,-16
   102ec:	00812423          	sw	s0,8(sp)
   102f0:	01212023          	sw	s2,0(sp)
   102f4:	00011437          	lui	s0,0x11
   102f8:	00011937          	lui	s2,0x11
   102fc:	6e440793          	addi	a5,s0,1764 # 116e4 <__init_array_start>
   10300:	6e490913          	addi	s2,s2,1764 # 116e4 <__init_array_start>
   10304:	40f90933          	sub	s2,s2,a5
   10308:	00112623          	sw	ra,12(sp)
   1030c:	00912223          	sw	s1,4(sp)
   10310:	40295913          	srai	s2,s2,0x2
   10314:	02090063          	beqz	s2,10334 <__libc_init_array+0x4c>
   10318:	6e440413          	addi	s0,s0,1764
   1031c:	00000493          	li	s1,0
   10320:	00042783          	lw	a5,0(s0)
   10324:	00148493          	addi	s1,s1,1
   10328:	00440413          	addi	s0,s0,4
   1032c:	000780e7          	jalr	a5
   10330:	fe9918e3          	bne	s2,s1,10320 <__libc_init_array+0x38>
   10334:	00011437          	lui	s0,0x11
   10338:	00011937          	lui	s2,0x11
   1033c:	6e440793          	addi	a5,s0,1764 # 116e4 <__init_array_start>
   10340:	6ec90913          	addi	s2,s2,1772 # 116ec <__init_array_end>
   10344:	40f90933          	sub	s2,s2,a5
   10348:	40295913          	srai	s2,s2,0x2
   1034c:	02090063          	beqz	s2,1036c <__libc_init_array+0x84>
   10350:	6e440413          	addi	s0,s0,1764
   10354:	00000493          	li	s1,0
   10358:	00042783          	lw	a5,0(s0)
   1035c:	00148493          	addi	s1,s1,1
   10360:	00440413          	addi	s0,s0,4
   10364:	000780e7          	jalr	a5
   10368:	fe9918e3          	bne	s2,s1,10358 <__libc_init_array+0x70>
   1036c:	00c12083          	lw	ra,12(sp)
   10370:	00812403          	lw	s0,8(sp)
   10374:	00412483          	lw	s1,4(sp)
   10378:	00012903          	lw	s2,0(sp)
   1037c:	01010113          	addi	sp,sp,16
   10380:	00008067          	ret

00010384 <memset>:
   10384:	00f00313          	li	t1,15
   10388:	00050713          	mv	a4,a0
   1038c:	02c37e63          	bgeu	t1,a2,103c8 <memset+0x44>
   10390:	00f77793          	andi	a5,a4,15
   10394:	0a079063          	bnez	a5,10434 <memset+0xb0>
   10398:	08059263          	bnez	a1,1041c <memset+0x98>
   1039c:	ff067693          	andi	a3,a2,-16
   103a0:	00f67613          	andi	a2,a2,15
   103a4:	00e686b3          	add	a3,a3,a4
   103a8:	00b72023          	sw	a1,0(a4)
   103ac:	00b72223          	sw	a1,4(a4)
   103b0:	00b72423          	sw	a1,8(a4)
   103b4:	00b72623          	sw	a1,12(a4)
   103b8:	01070713          	addi	a4,a4,16
   103bc:	fed766e3          	bltu	a4,a3,103a8 <memset+0x24>
   103c0:	00061463          	bnez	a2,103c8 <memset+0x44>
   103c4:	00008067          	ret
   103c8:	40c306b3          	sub	a3,t1,a2
   103cc:	00269693          	slli	a3,a3,0x2
   103d0:	00000297          	auipc	t0,0x0
   103d4:	005686b3          	add	a3,a3,t0
   103d8:	00c68067          	jr	12(a3)
   103dc:	00b70723          	sb	a1,14(a4)
   103e0:	00b706a3          	sb	a1,13(a4)
   103e4:	00b70623          	sb	a1,12(a4)
   103e8:	00b705a3          	sb	a1,11(a4)
   103ec:	00b70523          	sb	a1,10(a4)
   103f0:	00b704a3          	sb	a1,9(a4)
   103f4:	00b70423          	sb	a1,8(a4)
   103f8:	00b703a3          	sb	a1,7(a4)
   103fc:	00b70323          	sb	a1,6(a4)
   10400:	00b702a3          	sb	a1,5(a4)
   10404:	00b70223          	sb	a1,4(a4)
   10408:	00b701a3          	sb	a1,3(a4)
   1040c:	00b70123          	sb	a1,2(a4)
   10410:	00b700a3          	sb	a1,1(a4)
   10414:	00b70023          	sb	a1,0(a4)
   10418:	00008067          	ret
   1041c:	0ff5f593          	andi	a1,a1,255
   10420:	00859693          	slli	a3,a1,0x8
   10424:	00d5e5b3          	or	a1,a1,a3
   10428:	01059693          	slli	a3,a1,0x10
   1042c:	00d5e5b3          	or	a1,a1,a3
   10430:	f6dff06f          	j	1039c <memset+0x18>
   10434:	00279693          	slli	a3,a5,0x2
   10438:	00000297          	auipc	t0,0x0
   1043c:	005686b3          	add	a3,a3,t0
   10440:	00008293          	mv	t0,ra
   10444:	fa0680e7          	jalr	-96(a3)
   10448:	00028093          	mv	ra,t0
   1044c:	ff078793          	addi	a5,a5,-16
   10450:	40f70733          	sub	a4,a4,a5
   10454:	00f60633          	add	a2,a2,a5
   10458:	f6c378e3          	bgeu	t1,a2,103c8 <memset+0x44>
   1045c:	f3dff06f          	j	10398 <memset+0x14>

00010460 <__call_exitprocs>:
   10460:	fd010113          	addi	sp,sp,-48
   10464:	01412c23          	sw	s4,24(sp)
   10468:	c281aa03          	lw	s4,-984(gp) # 11b18 <_global_impure_ptr>
   1046c:	03212023          	sw	s2,32(sp)
   10470:	02112623          	sw	ra,44(sp)
   10474:	148a2903          	lw	s2,328(s4)
   10478:	02812423          	sw	s0,40(sp)
   1047c:	02912223          	sw	s1,36(sp)
   10480:	01312e23          	sw	s3,28(sp)
   10484:	01512a23          	sw	s5,20(sp)
   10488:	01612823          	sw	s6,16(sp)
   1048c:	01712623          	sw	s7,12(sp)
   10490:	01812423          	sw	s8,8(sp)
   10494:	04090063          	beqz	s2,104d4 <__call_exitprocs+0x74>
   10498:	00050b13          	mv	s6,a0
   1049c:	00058b93          	mv	s7,a1
   104a0:	00100a93          	li	s5,1
   104a4:	fff00993          	li	s3,-1
   104a8:	00492483          	lw	s1,4(s2)
   104ac:	fff48413          	addi	s0,s1,-1
   104b0:	02044263          	bltz	s0,104d4 <__call_exitprocs+0x74>
   104b4:	00249493          	slli	s1,s1,0x2
   104b8:	009904b3          	add	s1,s2,s1
   104bc:	040b8463          	beqz	s7,10504 <__call_exitprocs+0xa4>
   104c0:	1044a783          	lw	a5,260(s1)
   104c4:	05778063          	beq	a5,s7,10504 <__call_exitprocs+0xa4>
   104c8:	fff40413          	addi	s0,s0,-1
   104cc:	ffc48493          	addi	s1,s1,-4
   104d0:	ff3416e3          	bne	s0,s3,104bc <__call_exitprocs+0x5c>
   104d4:	02c12083          	lw	ra,44(sp)
   104d8:	02812403          	lw	s0,40(sp)
   104dc:	02412483          	lw	s1,36(sp)
   104e0:	02012903          	lw	s2,32(sp)
   104e4:	01c12983          	lw	s3,28(sp)
   104e8:	01812a03          	lw	s4,24(sp)
   104ec:	01412a83          	lw	s5,20(sp)
   104f0:	01012b03          	lw	s6,16(sp)
   104f4:	00c12b83          	lw	s7,12(sp)
   104f8:	00812c03          	lw	s8,8(sp)
   104fc:	03010113          	addi	sp,sp,48
   10500:	00008067          	ret
   10504:	00492783          	lw	a5,4(s2)
   10508:	0044a683          	lw	a3,4(s1)
   1050c:	fff78793          	addi	a5,a5,-1
   10510:	04878e63          	beq	a5,s0,1056c <__call_exitprocs+0x10c>
   10514:	0004a223          	sw	zero,4(s1)
   10518:	fa0688e3          	beqz	a3,104c8 <__call_exitprocs+0x68>
   1051c:	18892783          	lw	a5,392(s2)
   10520:	008a9733          	sll	a4,s5,s0
   10524:	00492c03          	lw	s8,4(s2)
   10528:	00f777b3          	and	a5,a4,a5
   1052c:	02079263          	bnez	a5,10550 <__call_exitprocs+0xf0>
   10530:	000680e7          	jalr	a3
   10534:	00492703          	lw	a4,4(s2)
   10538:	148a2783          	lw	a5,328(s4)
   1053c:	01871463          	bne	a4,s8,10544 <__call_exitprocs+0xe4>
   10540:	f8f904e3          	beq	s2,a5,104c8 <__call_exitprocs+0x68>
   10544:	f80788e3          	beqz	a5,104d4 <__call_exitprocs+0x74>
   10548:	00078913          	mv	s2,a5
   1054c:	f5dff06f          	j	104a8 <__call_exitprocs+0x48>
   10550:	18c92783          	lw	a5,396(s2)
   10554:	0844a583          	lw	a1,132(s1)
   10558:	00f77733          	and	a4,a4,a5
   1055c:	00071c63          	bnez	a4,10574 <__call_exitprocs+0x114>
   10560:	000b0513          	mv	a0,s6
   10564:	000680e7          	jalr	a3
   10568:	fcdff06f          	j	10534 <__call_exitprocs+0xd4>
   1056c:	00892223          	sw	s0,4(s2)
   10570:	fa9ff06f          	j	10518 <__call_exitprocs+0xb8>
   10574:	00058513          	mv	a0,a1
   10578:	000680e7          	jalr	a3
   1057c:	fb9ff06f          	j	10534 <__call_exitprocs+0xd4>

00010580 <__libc_fini_array>:
   10580:	ff010113          	addi	sp,sp,-16
   10584:	00812423          	sw	s0,8(sp)
   10588:	000117b7          	lui	a5,0x11
   1058c:	00011437          	lui	s0,0x11
   10590:	6ec40413          	addi	s0,s0,1772 # 116ec <__init_array_end>
   10594:	6f078793          	addi	a5,a5,1776 # 116f0 <__fini_array_end>
   10598:	408787b3          	sub	a5,a5,s0
   1059c:	00912223          	sw	s1,4(sp)
   105a0:	00112623          	sw	ra,12(sp)
   105a4:	4027d493          	srai	s1,a5,0x2
   105a8:	02048063          	beqz	s1,105c8 <__libc_fini_array+0x48>
   105ac:	ffc78793          	addi	a5,a5,-4
   105b0:	00878433          	add	s0,a5,s0
   105b4:	00042783          	lw	a5,0(s0)
   105b8:	fff48493          	addi	s1,s1,-1
   105bc:	ffc40413          	addi	s0,s0,-4
   105c0:	000780e7          	jalr	a5
   105c4:	fe0498e3          	bnez	s1,105b4 <__libc_fini_array+0x34>
   105c8:	00c12083          	lw	ra,12(sp)
   105cc:	00812403          	lw	s0,8(sp)
   105d0:	00412483          	lw	s1,4(sp)
   105d4:	01010113          	addi	sp,sp,16
   105d8:	00008067          	ret

000105dc <atexit>:
   105dc:	00050593          	mv	a1,a0
   105e0:	00000693          	li	a3,0
   105e4:	00000613          	li	a2,0
   105e8:	00000513          	li	a0,0
   105ec:	0040006f          	j	105f0 <__register_exitproc>

000105f0 <__register_exitproc>:
   105f0:	c281a703          	lw	a4,-984(gp) # 11b18 <_global_impure_ptr>
   105f4:	14872783          	lw	a5,328(a4)
   105f8:	04078c63          	beqz	a5,10650 <__register_exitproc+0x60>
   105fc:	0047a703          	lw	a4,4(a5)
   10600:	01f00813          	li	a6,31
   10604:	06e84e63          	blt	a6,a4,10680 <__register_exitproc+0x90>
   10608:	00271813          	slli	a6,a4,0x2
   1060c:	02050663          	beqz	a0,10638 <__register_exitproc+0x48>
   10610:	01078333          	add	t1,a5,a6
   10614:	08c32423          	sw	a2,136(t1) # 101cc <print_d+0x20>
   10618:	1887a883          	lw	a7,392(a5)
   1061c:	00100613          	li	a2,1
   10620:	00e61633          	sll	a2,a2,a4
   10624:	00c8e8b3          	or	a7,a7,a2
   10628:	1917a423          	sw	a7,392(a5)
   1062c:	10d32423          	sw	a3,264(t1)
   10630:	00200693          	li	a3,2
   10634:	02d50463          	beq	a0,a3,1065c <__register_exitproc+0x6c>
   10638:	00170713          	addi	a4,a4,1
   1063c:	00e7a223          	sw	a4,4(a5)
   10640:	010787b3          	add	a5,a5,a6
   10644:	00b7a423          	sw	a1,8(a5)
   10648:	00000513          	li	a0,0
   1064c:	00008067          	ret
   10650:	14c70793          	addi	a5,a4,332
   10654:	14f72423          	sw	a5,328(a4)
   10658:	fa5ff06f          	j	105fc <__register_exitproc+0xc>
   1065c:	18c7a683          	lw	a3,396(a5)
   10660:	00170713          	addi	a4,a4,1
   10664:	00e7a223          	sw	a4,4(a5)
   10668:	00c6e633          	or	a2,a3,a2
   1066c:	18c7a623          	sw	a2,396(a5)
   10670:	010787b3          	add	a5,a5,a6
   10674:	00b7a423          	sw	a1,8(a5)
   10678:	00000513          	li	a0,0
   1067c:	00008067          	ret
   10680:	fff00513          	li	a0,-1
   10684:	00008067          	ret

00010688 <_exit>:
   10688:	00000593          	li	a1,0
   1068c:	00000613          	li	a2,0
   10690:	00000693          	li	a3,0
   10694:	00000713          	li	a4,0
   10698:	00000793          	li	a5,0
   1069c:	05d00893          	li	a7,93
   106a0:	00000073          	ecall
   106a4:	00054463          	bltz	a0,106ac <_exit+0x24>
   106a8:	0000006f          	j	106a8 <_exit+0x20>
   106ac:	ff010113          	addi	sp,sp,-16
   106b0:	00812423          	sw	s0,8(sp)
   106b4:	00050413          	mv	s0,a0
   106b8:	00112623          	sw	ra,12(sp)
   106bc:	40800433          	neg	s0,s0
   106c0:	00c000ef          	jal	ra,106cc <__errno>
   106c4:	00852023          	sw	s0,0(a0)
   106c8:	0000006f          	j	106c8 <_exit+0x40>

000106cc <__errno>:
   106cc:	c301a503          	lw	a0,-976(gp) # 11b20 <_impure_ptr>
   106d0:	00008067          	ret

Disassembly of section .rodata:

000106d4 <.rodata>:
   106d4:	6874                	flw	fa3,84(s0)
   106d6:	2065                	jal	1077e <__errno+0xb2>
   106d8:	6164                	flw	fs1,68(a0)
   106da:	6174                	flw	fa3,68(a0)
   106dc:	6920                	flw	fs0,80(a0)
   106de:	          	ecall

Disassembly of section .eh_frame:

000116e0 <__FRAME_END__>:
   116e0:	0000                	unimp
	...

Disassembly of section .init_array:

000116e4 <__init_array_start>:
   116e4:	0074                	addi	a3,sp,12
   116e6:	0001                	nop

000116e8 <__frame_dummy_init_array_entry>:
   116e8:	012c                	addi	a1,sp,136
   116ea:	0001                	nop

Disassembly of section .fini_array:

000116ec <__do_global_dtors_aux_fini_array_entry>:
   116ec:	00dc                	addi	a5,sp,68
   116ee:	0001                	nop

Disassembly of section .data:

000116f0 <__DATA_BEGIN__>:
   116f0:	0000                	unimp
   116f2:	0000                	unimp
   116f4:	19dc                	addi	a5,sp,244
   116f6:	0001                	nop
   116f8:	1a44                	addi	s1,sp,308
   116fa:	0001                	nop
   116fc:	1aac                	addi	a1,sp,376
   116fe:	0001                	nop
	...
   11798:	0001                	nop
   1179a:	0000                	unimp
   1179c:	0000                	unimp
   1179e:	0000                	unimp
   117a0:	330e                	fld	ft6,224(sp)
   117a2:	abcd                	j	11d94 <__BSS_END__+0x254>
   117a4:	1234                	addi	a3,sp,296
   117a6:	e66d                	bnez	a2,11890 <__DATA_BEGIN__+0x1a0>
   117a8:	deec                	sw	a1,124(a3)
   117aa:	0005                	c.nop	1
   117ac:	0000000b          	0xb
	...

Disassembly of section .sdata:

00011b18 <_global_impure_ptr>:
   11b18:	16f0                	addi	a2,sp,876
   11b1a:	0001                	nop

00011b1c <__dso_handle>:
   11b1c:	0000                	unimp
	...

00011b20 <_impure_ptr>:
   11b20:	16f0                	addi	a2,sp,876
   11b22:	0001                	nop

Disassembly of section .bss:

00011b24 <__bss_start>:
   11b24:	0000                	unimp
	...

00011b28 <object.5495>:
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
