
32riscv-elf/helloworld.riscv:     file format elf32-littleriscv


Disassembly of section .text:

00010074 <register_fini>:
   10074:	000007b7          	lui	a5,0x0
   10078:	00078793          	mv	a5,a5
   1007c:	00078863          	beqz	a5,1008c <register_fini+0x18>
   10080:	00010537          	lui	a0,0x10
   10084:	55c50513          	addi	a0,a0,1372 # 1055c <__libc_fini_array>
   10088:	5300006f          	j	105b8 <atexit>
   1008c:	00008067          	ret

00010090 <_start>:
   10090:	00002197          	auipc	gp,0x2
   10094:	e4018193          	addi	gp,gp,-448 # 11ed0 <__global_pointer$>
   10098:	c3418513          	addi	a0,gp,-972 # 11b04 <_edata>
   1009c:	c5018613          	addi	a2,gp,-944 # 11b20 <__BSS_END__>
   100a0:	40a60633          	sub	a2,a2,a0
   100a4:	00000593          	li	a1,0
   100a8:	2b8000ef          	jal	ra,10360 <memset>
   100ac:	00000517          	auipc	a0,0x0
   100b0:	50c50513          	addi	a0,a0,1292 # 105b8 <atexit>
   100b4:	00050863          	beqz	a0,100c4 <_start+0x34>
   100b8:	00000517          	auipc	a0,0x0
   100bc:	4a450513          	addi	a0,a0,1188 # 1055c <__libc_fini_array>
   100c0:	4f8000ef          	jal	ra,105b8 <atexit>
   100c4:	200000ef          	jal	ra,102c4 <__libc_init_array>
   100c8:	00012503          	lw	a0,0(sp)
   100cc:	00410593          	addi	a1,sp,4
   100d0:	00000613          	li	a2,0
   100d4:	07c000ef          	jal	ra,10150 <main>
   100d8:	1bc0006f          	j	10294 <exit>

000100dc <__do_global_dtors_aux>:
   100dc:	c341c703          	lbu	a4,-972(gp) # 11b04 <_edata>
   100e0:	04071463          	bnez	a4,10128 <__do_global_dtors_aux+0x4c>
   100e4:	ff010113          	addi	sp,sp,-16
   100e8:	00812423          	sw	s0,8(sp)
   100ec:	00078413          	mv	s0,a5
   100f0:	000007b7          	lui	a5,0x0
   100f4:	00112623          	sw	ra,12(sp)
   100f8:	00078793          	mv	a5,a5
   100fc:	00078a63          	beqz	a5,10110 <__do_global_dtors_aux+0x34>
   10100:	00011537          	lui	a0,0x11
   10104:	6c050513          	addi	a0,a0,1728 # 116c0 <__FRAME_END__>
   10108:	00000097          	auipc	ra,0x0
   1010c:	000000e7          	jalr	zero # 0 <register_fini-0x10074>
   10110:	00100793          	li	a5,1
   10114:	00c12083          	lw	ra,12(sp)
   10118:	c2f18a23          	sb	a5,-972(gp) # 11b04 <_edata>
   1011c:	00812403          	lw	s0,8(sp)
   10120:	01010113          	addi	sp,sp,16
   10124:	00008067          	ret
   10128:	00008067          	ret

0001012c <frame_dummy>:
   1012c:	000007b7          	lui	a5,0x0
   10130:	00078793          	mv	a5,a5
   10134:	00078c63          	beqz	a5,1014c <frame_dummy+0x20>
   10138:	00011537          	lui	a0,0x11
   1013c:	c3818593          	addi	a1,gp,-968 # 11b08 <object.5495>
   10140:	6c050513          	addi	a0,a0,1728 # 116c0 <__FRAME_END__>
   10144:	00000317          	auipc	t1,0x0
   10148:	00000067          	jr	zero # 0 <register_fini-0x10074>
   1014c:	00008067          	ret

00010150 <main>:
   10150:	ff010113          	addi	sp,sp,-16
   10154:	00112623          	sw	ra,12(sp)
   10158:	00812423          	sw	s0,8(sp)
   1015c:	01010413          	addi	s0,sp,16
   10160:	000107b7          	lui	a5,0x10
   10164:	6b078513          	addi	a0,a5,1712 # 106b0 <__errno+0x8>
   10168:	048000ef          	jal	ra,101b0 <print_s>
   1016c:	098000ef          	jal	ra,10204 <exit_proc>
   10170:	00000793          	li	a5,0
   10174:	00078513          	mv	a0,a5
   10178:	00c12083          	lw	ra,12(sp)
   1017c:	00812403          	lw	s0,8(sp)
   10180:	01010113          	addi	sp,sp,16
   10184:	00008067          	ret

00010188 <print_d>:
   10188:	fe010113          	addi	sp,sp,-32
   1018c:	00812e23          	sw	s0,28(sp)
   10190:	02010413          	addi	s0,sp,32
   10194:	fea42623          	sw	a0,-20(s0)
   10198:	00200893          	li	a7,2
   1019c:	00000073          	ecall
   101a0:	00000013          	nop
   101a4:	01c12403          	lw	s0,28(sp)
   101a8:	02010113          	addi	sp,sp,32
   101ac:	00008067          	ret

000101b0 <print_s>:
   101b0:	fe010113          	addi	sp,sp,-32
   101b4:	00812e23          	sw	s0,28(sp)
   101b8:	02010413          	addi	s0,sp,32
   101bc:	fea42623          	sw	a0,-20(s0)
   101c0:	00000893          	li	a7,0
   101c4:	00000073          	ecall
   101c8:	00000013          	nop
   101cc:	01c12403          	lw	s0,28(sp)
   101d0:	02010113          	addi	sp,sp,32
   101d4:	00008067          	ret

000101d8 <print_c>:
   101d8:	fe010113          	addi	sp,sp,-32
   101dc:	00812e23          	sw	s0,28(sp)
   101e0:	02010413          	addi	s0,sp,32
   101e4:	00050793          	mv	a5,a0
   101e8:	fef407a3          	sb	a5,-17(s0)
   101ec:	00100893          	li	a7,1
   101f0:	00000073          	ecall
   101f4:	00000013          	nop
   101f8:	01c12403          	lw	s0,28(sp)
   101fc:	02010113          	addi	sp,sp,32
   10200:	00008067          	ret

00010204 <exit_proc>:
   10204:	ff010113          	addi	sp,sp,-16
   10208:	00812623          	sw	s0,12(sp)
   1020c:	01010413          	addi	s0,sp,16
   10210:	00300893          	li	a7,3
   10214:	00000073          	ecall
   10218:	00000013          	nop
   1021c:	00c12403          	lw	s0,12(sp)
   10220:	01010113          	addi	sp,sp,16
   10224:	00008067          	ret

00010228 <read_char>:
   10228:	fe010113          	addi	sp,sp,-32
   1022c:	00812e23          	sw	s0,28(sp)
   10230:	02010413          	addi	s0,sp,32
   10234:	00400893          	li	a7,4
   10238:	00000073          	ecall
   1023c:	00050793          	mv	a5,a0
   10240:	fef407a3          	sb	a5,-17(s0)
   10244:	fef44783          	lbu	a5,-17(s0)
   10248:	00078513          	mv	a0,a5
   1024c:	01c12403          	lw	s0,28(sp)
   10250:	02010113          	addi	sp,sp,32
   10254:	00008067          	ret

00010258 <read_num>:
   10258:	fe010113          	addi	sp,sp,-32
   1025c:	00812e23          	sw	s0,28(sp)
   10260:	02010413          	addi	s0,sp,32
   10264:	00500893          	li	a7,5
   10268:	00000073          	ecall
   1026c:	00050713          	mv	a4,a0
   10270:	fee42423          	sw	a4,-24(s0)
   10274:	fef42623          	sw	a5,-20(s0)
   10278:	fe842703          	lw	a4,-24(s0)
   1027c:	fec42783          	lw	a5,-20(s0)
   10280:	00070513          	mv	a0,a4
   10284:	00078593          	mv	a1,a5
   10288:	01c12403          	lw	s0,28(sp)
   1028c:	02010113          	addi	sp,sp,32
   10290:	00008067          	ret

00010294 <exit>:
   10294:	ff010113          	addi	sp,sp,-16
   10298:	00000593          	li	a1,0
   1029c:	00812423          	sw	s0,8(sp)
   102a0:	00112623          	sw	ra,12(sp)
   102a4:	00050413          	mv	s0,a0
   102a8:	194000ef          	jal	ra,1043c <__call_exitprocs>
   102ac:	c281a503          	lw	a0,-984(gp) # 11af8 <_global_impure_ptr>
   102b0:	03c52783          	lw	a5,60(a0)
   102b4:	00078463          	beqz	a5,102bc <exit+0x28>
   102b8:	000780e7          	jalr	a5
   102bc:	00040513          	mv	a0,s0
   102c0:	3a4000ef          	jal	ra,10664 <_exit>

000102c4 <__libc_init_array>:
   102c4:	ff010113          	addi	sp,sp,-16
   102c8:	00812423          	sw	s0,8(sp)
   102cc:	01212023          	sw	s2,0(sp)
   102d0:	00011437          	lui	s0,0x11
   102d4:	00011937          	lui	s2,0x11
   102d8:	6c440793          	addi	a5,s0,1732 # 116c4 <__init_array_start>
   102dc:	6c490913          	addi	s2,s2,1732 # 116c4 <__init_array_start>
   102e0:	40f90933          	sub	s2,s2,a5
   102e4:	00112623          	sw	ra,12(sp)
   102e8:	00912223          	sw	s1,4(sp)
   102ec:	40295913          	srai	s2,s2,0x2
   102f0:	02090063          	beqz	s2,10310 <__libc_init_array+0x4c>
   102f4:	6c440413          	addi	s0,s0,1732
   102f8:	00000493          	li	s1,0
   102fc:	00042783          	lw	a5,0(s0)
   10300:	00148493          	addi	s1,s1,1
   10304:	00440413          	addi	s0,s0,4
   10308:	000780e7          	jalr	a5
   1030c:	fe9918e3          	bne	s2,s1,102fc <__libc_init_array+0x38>
   10310:	00011437          	lui	s0,0x11
   10314:	00011937          	lui	s2,0x11
   10318:	6c440793          	addi	a5,s0,1732 # 116c4 <__init_array_start>
   1031c:	6cc90913          	addi	s2,s2,1740 # 116cc <__init_array_end>
   10320:	40f90933          	sub	s2,s2,a5
   10324:	40295913          	srai	s2,s2,0x2
   10328:	02090063          	beqz	s2,10348 <__libc_init_array+0x84>
   1032c:	6c440413          	addi	s0,s0,1732
   10330:	00000493          	li	s1,0
   10334:	00042783          	lw	a5,0(s0)
   10338:	00148493          	addi	s1,s1,1
   1033c:	00440413          	addi	s0,s0,4
   10340:	000780e7          	jalr	a5
   10344:	fe9918e3          	bne	s2,s1,10334 <__libc_init_array+0x70>
   10348:	00c12083          	lw	ra,12(sp)
   1034c:	00812403          	lw	s0,8(sp)
   10350:	00412483          	lw	s1,4(sp)
   10354:	00012903          	lw	s2,0(sp)
   10358:	01010113          	addi	sp,sp,16
   1035c:	00008067          	ret

00010360 <memset>:
   10360:	00f00313          	li	t1,15
   10364:	00050713          	mv	a4,a0
   10368:	02c37e63          	bgeu	t1,a2,103a4 <memset+0x44>
   1036c:	00f77793          	andi	a5,a4,15
   10370:	0a079063          	bnez	a5,10410 <memset+0xb0>
   10374:	08059263          	bnez	a1,103f8 <memset+0x98>
   10378:	ff067693          	andi	a3,a2,-16
   1037c:	00f67613          	andi	a2,a2,15
   10380:	00e686b3          	add	a3,a3,a4
   10384:	00b72023          	sw	a1,0(a4)
   10388:	00b72223          	sw	a1,4(a4)
   1038c:	00b72423          	sw	a1,8(a4)
   10390:	00b72623          	sw	a1,12(a4)
   10394:	01070713          	addi	a4,a4,16
   10398:	fed766e3          	bltu	a4,a3,10384 <memset+0x24>
   1039c:	00061463          	bnez	a2,103a4 <memset+0x44>
   103a0:	00008067          	ret
   103a4:	40c306b3          	sub	a3,t1,a2
   103a8:	00269693          	slli	a3,a3,0x2
   103ac:	00000297          	auipc	t0,0x0
   103b0:	005686b3          	add	a3,a3,t0
   103b4:	00c68067          	jr	12(a3)
   103b8:	00b70723          	sb	a1,14(a4)
   103bc:	00b706a3          	sb	a1,13(a4)
   103c0:	00b70623          	sb	a1,12(a4)
   103c4:	00b705a3          	sb	a1,11(a4)
   103c8:	00b70523          	sb	a1,10(a4)
   103cc:	00b704a3          	sb	a1,9(a4)
   103d0:	00b70423          	sb	a1,8(a4)
   103d4:	00b703a3          	sb	a1,7(a4)
   103d8:	00b70323          	sb	a1,6(a4)
   103dc:	00b702a3          	sb	a1,5(a4)
   103e0:	00b70223          	sb	a1,4(a4)
   103e4:	00b701a3          	sb	a1,3(a4)
   103e8:	00b70123          	sb	a1,2(a4)
   103ec:	00b700a3          	sb	a1,1(a4)
   103f0:	00b70023          	sb	a1,0(a4)
   103f4:	00008067          	ret
   103f8:	0ff5f593          	andi	a1,a1,255
   103fc:	00859693          	slli	a3,a1,0x8
   10400:	00d5e5b3          	or	a1,a1,a3
   10404:	01059693          	slli	a3,a1,0x10
   10408:	00d5e5b3          	or	a1,a1,a3
   1040c:	f6dff06f          	j	10378 <memset+0x18>
   10410:	00279693          	slli	a3,a5,0x2
   10414:	00000297          	auipc	t0,0x0
   10418:	005686b3          	add	a3,a3,t0
   1041c:	00008293          	mv	t0,ra
   10420:	fa0680e7          	jalr	-96(a3)
   10424:	00028093          	mv	ra,t0
   10428:	ff078793          	addi	a5,a5,-16
   1042c:	40f70733          	sub	a4,a4,a5
   10430:	00f60633          	add	a2,a2,a5
   10434:	f6c378e3          	bgeu	t1,a2,103a4 <memset+0x44>
   10438:	f3dff06f          	j	10374 <memset+0x14>

0001043c <__call_exitprocs>:
   1043c:	fd010113          	addi	sp,sp,-48
   10440:	01412c23          	sw	s4,24(sp)
   10444:	c281aa03          	lw	s4,-984(gp) # 11af8 <_global_impure_ptr>
   10448:	03212023          	sw	s2,32(sp)
   1044c:	02112623          	sw	ra,44(sp)
   10450:	148a2903          	lw	s2,328(s4)
   10454:	02812423          	sw	s0,40(sp)
   10458:	02912223          	sw	s1,36(sp)
   1045c:	01312e23          	sw	s3,28(sp)
   10460:	01512a23          	sw	s5,20(sp)
   10464:	01612823          	sw	s6,16(sp)
   10468:	01712623          	sw	s7,12(sp)
   1046c:	01812423          	sw	s8,8(sp)
   10470:	04090063          	beqz	s2,104b0 <__call_exitprocs+0x74>
   10474:	00050b13          	mv	s6,a0
   10478:	00058b93          	mv	s7,a1
   1047c:	00100a93          	li	s5,1
   10480:	fff00993          	li	s3,-1
   10484:	00492483          	lw	s1,4(s2)
   10488:	fff48413          	addi	s0,s1,-1
   1048c:	02044263          	bltz	s0,104b0 <__call_exitprocs+0x74>
   10490:	00249493          	slli	s1,s1,0x2
   10494:	009904b3          	add	s1,s2,s1
   10498:	040b8463          	beqz	s7,104e0 <__call_exitprocs+0xa4>
   1049c:	1044a783          	lw	a5,260(s1)
   104a0:	05778063          	beq	a5,s7,104e0 <__call_exitprocs+0xa4>
   104a4:	fff40413          	addi	s0,s0,-1
   104a8:	ffc48493          	addi	s1,s1,-4
   104ac:	ff3416e3          	bne	s0,s3,10498 <__call_exitprocs+0x5c>
   104b0:	02c12083          	lw	ra,44(sp)
   104b4:	02812403          	lw	s0,40(sp)
   104b8:	02412483          	lw	s1,36(sp)
   104bc:	02012903          	lw	s2,32(sp)
   104c0:	01c12983          	lw	s3,28(sp)
   104c4:	01812a03          	lw	s4,24(sp)
   104c8:	01412a83          	lw	s5,20(sp)
   104cc:	01012b03          	lw	s6,16(sp)
   104d0:	00c12b83          	lw	s7,12(sp)
   104d4:	00812c03          	lw	s8,8(sp)
   104d8:	03010113          	addi	sp,sp,48
   104dc:	00008067          	ret
   104e0:	00492783          	lw	a5,4(s2)
   104e4:	0044a683          	lw	a3,4(s1)
   104e8:	fff78793          	addi	a5,a5,-1
   104ec:	04878e63          	beq	a5,s0,10548 <__call_exitprocs+0x10c>
   104f0:	0004a223          	sw	zero,4(s1)
   104f4:	fa0688e3          	beqz	a3,104a4 <__call_exitprocs+0x68>
   104f8:	18892783          	lw	a5,392(s2)
   104fc:	008a9733          	sll	a4,s5,s0
   10500:	00492c03          	lw	s8,4(s2)
   10504:	00f777b3          	and	a5,a4,a5
   10508:	02079263          	bnez	a5,1052c <__call_exitprocs+0xf0>
   1050c:	000680e7          	jalr	a3
   10510:	00492703          	lw	a4,4(s2)
   10514:	148a2783          	lw	a5,328(s4)
   10518:	01871463          	bne	a4,s8,10520 <__call_exitprocs+0xe4>
   1051c:	f8f904e3          	beq	s2,a5,104a4 <__call_exitprocs+0x68>
   10520:	f80788e3          	beqz	a5,104b0 <__call_exitprocs+0x74>
   10524:	00078913          	mv	s2,a5
   10528:	f5dff06f          	j	10484 <__call_exitprocs+0x48>
   1052c:	18c92783          	lw	a5,396(s2)
   10530:	0844a583          	lw	a1,132(s1)
   10534:	00f77733          	and	a4,a4,a5
   10538:	00071c63          	bnez	a4,10550 <__call_exitprocs+0x114>
   1053c:	000b0513          	mv	a0,s6
   10540:	000680e7          	jalr	a3
   10544:	fcdff06f          	j	10510 <__call_exitprocs+0xd4>
   10548:	00892223          	sw	s0,4(s2)
   1054c:	fa9ff06f          	j	104f4 <__call_exitprocs+0xb8>
   10550:	00058513          	mv	a0,a1
   10554:	000680e7          	jalr	a3
   10558:	fb9ff06f          	j	10510 <__call_exitprocs+0xd4>

0001055c <__libc_fini_array>:
   1055c:	ff010113          	addi	sp,sp,-16
   10560:	00812423          	sw	s0,8(sp)
   10564:	000117b7          	lui	a5,0x11
   10568:	00011437          	lui	s0,0x11
   1056c:	6cc40413          	addi	s0,s0,1740 # 116cc <__init_array_end>
   10570:	6d078793          	addi	a5,a5,1744 # 116d0 <__fini_array_end>
   10574:	408787b3          	sub	a5,a5,s0
   10578:	00912223          	sw	s1,4(sp)
   1057c:	00112623          	sw	ra,12(sp)
   10580:	4027d493          	srai	s1,a5,0x2
   10584:	02048063          	beqz	s1,105a4 <__libc_fini_array+0x48>
   10588:	ffc78793          	addi	a5,a5,-4
   1058c:	00878433          	add	s0,a5,s0
   10590:	00042783          	lw	a5,0(s0)
   10594:	fff48493          	addi	s1,s1,-1
   10598:	ffc40413          	addi	s0,s0,-4
   1059c:	000780e7          	jalr	a5
   105a0:	fe0498e3          	bnez	s1,10590 <__libc_fini_array+0x34>
   105a4:	00c12083          	lw	ra,12(sp)
   105a8:	00812403          	lw	s0,8(sp)
   105ac:	00412483          	lw	s1,4(sp)
   105b0:	01010113          	addi	sp,sp,16
   105b4:	00008067          	ret

000105b8 <atexit>:
   105b8:	00050593          	mv	a1,a0
   105bc:	00000693          	li	a3,0
   105c0:	00000613          	li	a2,0
   105c4:	00000513          	li	a0,0
   105c8:	0040006f          	j	105cc <__register_exitproc>

000105cc <__register_exitproc>:
   105cc:	c281a703          	lw	a4,-984(gp) # 11af8 <_global_impure_ptr>
   105d0:	14872783          	lw	a5,328(a4)
   105d4:	04078c63          	beqz	a5,1062c <__register_exitproc+0x60>
   105d8:	0047a703          	lw	a4,4(a5)
   105dc:	01f00813          	li	a6,31
   105e0:	06e84e63          	blt	a6,a4,1065c <__register_exitproc+0x90>
   105e4:	00271813          	slli	a6,a4,0x2
   105e8:	02050663          	beqz	a0,10614 <__register_exitproc+0x48>
   105ec:	01078333          	add	t1,a5,a6
   105f0:	08c32423          	sw	a2,136(t1) # 101cc <print_s+0x1c>
   105f4:	1887a883          	lw	a7,392(a5)
   105f8:	00100613          	li	a2,1
   105fc:	00e61633          	sll	a2,a2,a4
   10600:	00c8e8b3          	or	a7,a7,a2
   10604:	1917a423          	sw	a7,392(a5)
   10608:	10d32423          	sw	a3,264(t1)
   1060c:	00200693          	li	a3,2
   10610:	02d50463          	beq	a0,a3,10638 <__register_exitproc+0x6c>
   10614:	00170713          	addi	a4,a4,1
   10618:	00e7a223          	sw	a4,4(a5)
   1061c:	010787b3          	add	a5,a5,a6
   10620:	00b7a423          	sw	a1,8(a5)
   10624:	00000513          	li	a0,0
   10628:	00008067          	ret
   1062c:	14c70793          	addi	a5,a4,332
   10630:	14f72423          	sw	a5,328(a4)
   10634:	fa5ff06f          	j	105d8 <__register_exitproc+0xc>
   10638:	18c7a683          	lw	a3,396(a5)
   1063c:	00170713          	addi	a4,a4,1
   10640:	00e7a223          	sw	a4,4(a5)
   10644:	00c6e633          	or	a2,a3,a2
   10648:	18c7a623          	sw	a2,396(a5)
   1064c:	010787b3          	add	a5,a5,a6
   10650:	00b7a423          	sw	a1,8(a5)
   10654:	00000513          	li	a0,0
   10658:	00008067          	ret
   1065c:	fff00513          	li	a0,-1
   10660:	00008067          	ret

00010664 <_exit>:
   10664:	00000593          	li	a1,0
   10668:	00000613          	li	a2,0
   1066c:	00000693          	li	a3,0
   10670:	00000713          	li	a4,0
   10674:	00000793          	li	a5,0
   10678:	05d00893          	li	a7,93
   1067c:	00000073          	ecall
   10680:	00054463          	bltz	a0,10688 <_exit+0x24>
   10684:	0000006f          	j	10684 <_exit+0x20>
   10688:	ff010113          	addi	sp,sp,-16
   1068c:	00812423          	sw	s0,8(sp)
   10690:	00050413          	mv	s0,a0
   10694:	00112623          	sw	ra,12(sp)
   10698:	40800433          	neg	s0,s0
   1069c:	00c000ef          	jal	ra,106a8 <__errno>
   106a0:	00852023          	sw	s0,0(a0)
   106a4:	0000006f          	j	106a4 <_exit+0x40>

000106a8 <__errno>:
   106a8:	c301a503          	lw	a0,-976(gp) # 11b00 <_impure_ptr>
   106ac:	00008067          	ret

Disassembly of section .rodata:

000106b0 <.rodata>:
   106b0:	6548                	flw	fa0,12(a0)
   106b2:	6c6c                	flw	fa1,92(s0)
   106b4:	57202c6f          	jal	s8,12c26 <__global_pointer$+0xd56>
   106b8:	646c726f          	jal	tp,d7cfe <__global_pointer$+0xc5e2e>
   106bc:	0a21                	addi	s4,s4,8
	...

Disassembly of section .eh_frame:

000116c0 <__FRAME_END__>:
   116c0:	0000                	unimp
	...

Disassembly of section .init_array:

000116c4 <__init_array_start>:
   116c4:	0074                	addi	a3,sp,12
   116c6:	0001                	nop

000116c8 <__frame_dummy_init_array_entry>:
   116c8:	012c                	addi	a1,sp,136
   116ca:	0001                	nop

Disassembly of section .fini_array:

000116cc <__do_global_dtors_aux_fini_array_entry>:
   116cc:	00dc                	addi	a5,sp,68
   116ce:	0001                	nop

Disassembly of section .data:

000116d0 <__DATA_BEGIN__>:
   116d0:	0000                	unimp
   116d2:	0000                	unimp
   116d4:	19bc                	addi	a5,sp,248
   116d6:	0001                	nop
   116d8:	1a24                	addi	s1,sp,312
   116da:	0001                	nop
   116dc:	1a8c                	addi	a1,sp,368
   116de:	0001                	nop
	...
   11778:	0001                	nop
   1177a:	0000                	unimp
   1177c:	0000                	unimp
   1177e:	0000                	unimp
   11780:	330e                	fld	ft6,224(sp)
   11782:	abcd                	j	11d74 <__BSS_END__+0x254>
   11784:	1234                	addi	a3,sp,296
   11786:	e66d                	bnez	a2,11870 <__DATA_BEGIN__+0x1a0>
   11788:	deec                	sw	a1,124(a3)
   1178a:	0005                	c.nop	1
   1178c:	0000000b          	0xb
	...

Disassembly of section .sdata:

00011af8 <_global_impure_ptr>:
   11af8:	16d0                	addi	a2,sp,868
   11afa:	0001                	nop

00011afc <__dso_handle>:
   11afc:	0000                	unimp
	...

00011b00 <_impure_ptr>:
   11b00:	16d0                	addi	a2,sp,868
   11b02:	0001                	nop

Disassembly of section .bss:

00011b04 <__bss_start>:
   11b04:	0000                	unimp
	...

00011b08 <object.5495>:
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
