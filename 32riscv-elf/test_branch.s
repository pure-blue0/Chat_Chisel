
32riscv-elf/test_branch.riscv:     file format elf32-littleriscv


Disassembly of section .text:

00010074 <register_fini>:
   10074:	000007b7          	lui	a5,0x0
   10078:	00078793          	mv	a5,a5
   1007c:	00078863          	beqz	a5,1008c <register_fini+0x18>
   10080:	00010537          	lui	a0,0x10
   10084:	6dc50513          	addi	a0,a0,1756 # 106dc <__libc_fini_array>
   10088:	6b00006f          	j	10738 <atexit>
   1008c:	00008067          	ret

00010090 <_start>:
   10090:	00002197          	auipc	gp,0x2
   10094:	01018193          	addi	gp,gp,16 # 120a0 <__global_pointer$>
   10098:	c3418513          	addi	a0,gp,-972 # 11cd4 <_edata>
   1009c:	c5018613          	addi	a2,gp,-944 # 11cf0 <__BSS_END__>
   100a0:	40a60633          	sub	a2,a2,a0
   100a4:	00000593          	li	a1,0
   100a8:	438000ef          	jal	ra,104e0 <memset>
   100ac:	00000517          	auipc	a0,0x0
   100b0:	68c50513          	addi	a0,a0,1676 # 10738 <atexit>
   100b4:	00050863          	beqz	a0,100c4 <_start+0x34>
   100b8:	00000517          	auipc	a0,0x0
   100bc:	62450513          	addi	a0,a0,1572 # 106dc <__libc_fini_array>
   100c0:	678000ef          	jal	ra,10738 <atexit>
   100c4:	380000ef          	jal	ra,10444 <__libc_init_array>
   100c8:	00012503          	lw	a0,0(sp)
   100cc:	00410593          	addi	a1,sp,4
   100d0:	00000613          	li	a2,0
   100d4:	07c000ef          	jal	ra,10150 <main>
   100d8:	33c0006f          	j	10414 <exit>

000100dc <__do_global_dtors_aux>:
   100dc:	c341c703          	lbu	a4,-972(gp) # 11cd4 <_edata>
   100e0:	04071463          	bnez	a4,10128 <__do_global_dtors_aux+0x4c>
   100e4:	ff010113          	addi	sp,sp,-16
   100e8:	00812423          	sw	s0,8(sp)
   100ec:	00078413          	mv	s0,a5
   100f0:	000007b7          	lui	a5,0x0
   100f4:	00112623          	sw	ra,12(sp)
   100f8:	00078793          	mv	a5,a5
   100fc:	00078a63          	beqz	a5,10110 <__do_global_dtors_aux+0x34>
   10100:	00012537          	lui	a0,0x12
   10104:	88c50513          	addi	a0,a0,-1908 # 1188c <__FRAME_END__>
   10108:	00000097          	auipc	ra,0x0
   1010c:	000000e7          	jalr	zero # 0 <register_fini-0x10074>
   10110:	00100793          	li	a5,1
   10114:	00c12083          	lw	ra,12(sp)
   10118:	c2f18a23          	sb	a5,-972(gp) # 11cd4 <_edata>
   1011c:	00812403          	lw	s0,8(sp)
   10120:	01010113          	addi	sp,sp,16
   10124:	00008067          	ret
   10128:	00008067          	ret

0001012c <frame_dummy>:
   1012c:	000007b7          	lui	a5,0x0
   10130:	00078793          	mv	a5,a5
   10134:	00078c63          	beqz	a5,1014c <frame_dummy+0x20>
   10138:	00012537          	lui	a0,0x12
   1013c:	c3818593          	addi	a1,gp,-968 # 11cd8 <object.5495>
   10140:	88c50513          	addi	a0,a0,-1908 # 1188c <__FRAME_END__>
   10144:	00000317          	auipc	t1,0x0
   10148:	00000067          	jr	zero # 0 <register_fini-0x10074>
   1014c:	00008067          	ret

00010150 <main>:
   10150:	fc010113          	addi	sp,sp,-64
   10154:	02112e23          	sw	ra,60(sp)
   10158:	02812c23          	sw	s0,56(sp)
   1015c:	04010413          	addi	s0,sp,64
   10160:	fe042023          	sw	zero,-32(s0)
   10164:	00100793          	li	a5,1
   10168:	fcf42e23          	sw	a5,-36(s0)
   1016c:	000117b7          	lui	a5,0x11
   10170:	87878793          	addi	a5,a5,-1928 # 10878 <__errno+0x50>
   10174:	0007a583          	lw	a1,0(a5)
   10178:	0047a603          	lw	a2,4(a5)
   1017c:	0087a683          	lw	a3,8(a5)
   10180:	00c7a703          	lw	a4,12(a5)
   10184:	0107a783          	lw	a5,16(a5)
   10188:	fcb42423          	sw	a1,-56(s0)
   1018c:	fcc42623          	sw	a2,-52(s0)
   10190:	fcd42823          	sw	a3,-48(s0)
   10194:	fce42a23          	sw	a4,-44(s0)
   10198:	fcf42c23          	sw	a5,-40(s0)
   1019c:	fe042783          	lw	a5,-32(s0)
   101a0:	00078863          	beqz	a5,101b0 <main+0x60>
   101a4:	000117b7          	lui	a5,0x11
   101a8:	83078513          	addi	a0,a5,-2000 # 10830 <__errno+0x8>
   101ac:	184000ef          	jal	ra,10330 <print_s>
   101b0:	fdc42783          	lw	a5,-36(s0)
   101b4:	00078863          	beqz	a5,101c4 <main+0x74>
   101b8:	000117b7          	lui	a5,0x11
   101bc:	85c78513          	addi	a0,a5,-1956 # 1085c <__errno+0x34>
   101c0:	170000ef          	jal	ra,10330 <print_s>
   101c4:	000117b7          	lui	a5,0x11
   101c8:	87078513          	addi	a0,a5,-1936 # 10870 <__errno+0x48>
   101cc:	164000ef          	jal	ra,10330 <print_s>
   101d0:	fe042623          	sw	zero,-20(s0)
   101d4:	0340006f          	j	10208 <main+0xb8>
   101d8:	fec42783          	lw	a5,-20(s0)
   101dc:	00279793          	slli	a5,a5,0x2
   101e0:	ff040713          	addi	a4,s0,-16
   101e4:	00f707b3          	add	a5,a4,a5
   101e8:	fd87a783          	lw	a5,-40(a5)
   101ec:	00078513          	mv	a0,a5
   101f0:	118000ef          	jal	ra,10308 <print_d>
   101f4:	02000513          	li	a0,32
   101f8:	160000ef          	jal	ra,10358 <print_c>
   101fc:	fec42783          	lw	a5,-20(s0)
   10200:	00178793          	addi	a5,a5,1
   10204:	fef42623          	sw	a5,-20(s0)
   10208:	fec42703          	lw	a4,-20(s0)
   1020c:	00400793          	li	a5,4
   10210:	fce7d4e3          	bge	a5,a4,101d8 <main+0x88>
   10214:	00a00513          	li	a0,10
   10218:	140000ef          	jal	ra,10358 <print_c>
   1021c:	00100793          	li	a5,1
   10220:	fef42423          	sw	a5,-24(s0)
   10224:	0640006f          	j	10288 <main+0x138>
   10228:	fe842783          	lw	a5,-24(s0)
   1022c:	00279793          	slli	a5,a5,0x2
   10230:	ff040713          	addi	a4,s0,-16
   10234:	00f707b3          	add	a5,a4,a5
   10238:	fd87a683          	lw	a3,-40(a5)
   1023c:	fe842783          	lw	a5,-24(s0)
   10240:	fff78793          	addi	a5,a5,-1
   10244:	00279793          	slli	a5,a5,0x2
   10248:	ff040713          	addi	a4,s0,-16
   1024c:	00f707b3          	add	a5,a4,a5
   10250:	fd87a703          	lw	a4,-40(a5)
   10254:	00070793          	mv	a5,a4
   10258:	00279793          	slli	a5,a5,0x2
   1025c:	00e787b3          	add	a5,a5,a4
   10260:	00179793          	slli	a5,a5,0x1
   10264:	00f68733          	add	a4,a3,a5
   10268:	fe842783          	lw	a5,-24(s0)
   1026c:	00279793          	slli	a5,a5,0x2
   10270:	ff040693          	addi	a3,s0,-16
   10274:	00f687b3          	add	a5,a3,a5
   10278:	fce7ac23          	sw	a4,-40(a5)
   1027c:	fe842783          	lw	a5,-24(s0)
   10280:	00178793          	addi	a5,a5,1
   10284:	fef42423          	sw	a5,-24(s0)
   10288:	fe842703          	lw	a4,-24(s0)
   1028c:	00400793          	li	a5,4
   10290:	f8e7dce3          	bge	a5,a4,10228 <main+0xd8>
   10294:	000117b7          	lui	a5,0x11
   10298:	87078513          	addi	a0,a5,-1936 # 10870 <__errno+0x48>
   1029c:	094000ef          	jal	ra,10330 <print_s>
   102a0:	fe042223          	sw	zero,-28(s0)
   102a4:	0340006f          	j	102d8 <main+0x188>
   102a8:	fe442783          	lw	a5,-28(s0)
   102ac:	00279793          	slli	a5,a5,0x2
   102b0:	ff040713          	addi	a4,s0,-16
   102b4:	00f707b3          	add	a5,a4,a5
   102b8:	fd87a783          	lw	a5,-40(a5)
   102bc:	00078513          	mv	a0,a5
   102c0:	048000ef          	jal	ra,10308 <print_d>
   102c4:	02000513          	li	a0,32
   102c8:	090000ef          	jal	ra,10358 <print_c>
   102cc:	fe442783          	lw	a5,-28(s0)
   102d0:	00178793          	addi	a5,a5,1
   102d4:	fef42223          	sw	a5,-28(s0)
   102d8:	fe442703          	lw	a4,-28(s0)
   102dc:	00400793          	li	a5,4
   102e0:	fce7d4e3          	bge	a5,a4,102a8 <main+0x158>
   102e4:	00a00513          	li	a0,10
   102e8:	070000ef          	jal	ra,10358 <print_c>
   102ec:	098000ef          	jal	ra,10384 <exit_proc>
   102f0:	00000793          	li	a5,0
   102f4:	00078513          	mv	a0,a5
   102f8:	03c12083          	lw	ra,60(sp)
   102fc:	03812403          	lw	s0,56(sp)
   10300:	04010113          	addi	sp,sp,64
   10304:	00008067          	ret

00010308 <print_d>:
   10308:	fe010113          	addi	sp,sp,-32
   1030c:	00812e23          	sw	s0,28(sp)
   10310:	02010413          	addi	s0,sp,32
   10314:	fea42623          	sw	a0,-20(s0)
   10318:	00200893          	li	a7,2
   1031c:	00000073          	ecall
   10320:	00000013          	nop
   10324:	01c12403          	lw	s0,28(sp)
   10328:	02010113          	addi	sp,sp,32
   1032c:	00008067          	ret

00010330 <print_s>:
   10330:	fe010113          	addi	sp,sp,-32
   10334:	00812e23          	sw	s0,28(sp)
   10338:	02010413          	addi	s0,sp,32
   1033c:	fea42623          	sw	a0,-20(s0)
   10340:	00000893          	li	a7,0
   10344:	00000073          	ecall
   10348:	00000013          	nop
   1034c:	01c12403          	lw	s0,28(sp)
   10350:	02010113          	addi	sp,sp,32
   10354:	00008067          	ret

00010358 <print_c>:
   10358:	fe010113          	addi	sp,sp,-32
   1035c:	00812e23          	sw	s0,28(sp)
   10360:	02010413          	addi	s0,sp,32
   10364:	00050793          	mv	a5,a0
   10368:	fef407a3          	sb	a5,-17(s0)
   1036c:	00100893          	li	a7,1
   10370:	00000073          	ecall
   10374:	00000013          	nop
   10378:	01c12403          	lw	s0,28(sp)
   1037c:	02010113          	addi	sp,sp,32
   10380:	00008067          	ret

00010384 <exit_proc>:
   10384:	ff010113          	addi	sp,sp,-16
   10388:	00812623          	sw	s0,12(sp)
   1038c:	01010413          	addi	s0,sp,16
   10390:	00300893          	li	a7,3
   10394:	00000073          	ecall
   10398:	00000013          	nop
   1039c:	00c12403          	lw	s0,12(sp)
   103a0:	01010113          	addi	sp,sp,16
   103a4:	00008067          	ret

000103a8 <read_char>:
   103a8:	fe010113          	addi	sp,sp,-32
   103ac:	00812e23          	sw	s0,28(sp)
   103b0:	02010413          	addi	s0,sp,32
   103b4:	00400893          	li	a7,4
   103b8:	00000073          	ecall
   103bc:	00050793          	mv	a5,a0
   103c0:	fef407a3          	sb	a5,-17(s0)
   103c4:	fef44783          	lbu	a5,-17(s0)
   103c8:	00078513          	mv	a0,a5
   103cc:	01c12403          	lw	s0,28(sp)
   103d0:	02010113          	addi	sp,sp,32
   103d4:	00008067          	ret

000103d8 <read_num>:
   103d8:	fe010113          	addi	sp,sp,-32
   103dc:	00812e23          	sw	s0,28(sp)
   103e0:	02010413          	addi	s0,sp,32
   103e4:	00500893          	li	a7,5
   103e8:	00000073          	ecall
   103ec:	00050713          	mv	a4,a0
   103f0:	fee42423          	sw	a4,-24(s0)
   103f4:	fef42623          	sw	a5,-20(s0)
   103f8:	fe842703          	lw	a4,-24(s0)
   103fc:	fec42783          	lw	a5,-20(s0)
   10400:	00070513          	mv	a0,a4
   10404:	00078593          	mv	a1,a5
   10408:	01c12403          	lw	s0,28(sp)
   1040c:	02010113          	addi	sp,sp,32
   10410:	00008067          	ret

00010414 <exit>:
   10414:	ff010113          	addi	sp,sp,-16
   10418:	00000593          	li	a1,0
   1041c:	00812423          	sw	s0,8(sp)
   10420:	00112623          	sw	ra,12(sp)
   10424:	00050413          	mv	s0,a0
   10428:	194000ef          	jal	ra,105bc <__call_exitprocs>
   1042c:	c281a503          	lw	a0,-984(gp) # 11cc8 <_global_impure_ptr>
   10430:	03c52783          	lw	a5,60(a0)
   10434:	00078463          	beqz	a5,1043c <exit+0x28>
   10438:	000780e7          	jalr	a5
   1043c:	00040513          	mv	a0,s0
   10440:	3a4000ef          	jal	ra,107e4 <_exit>

00010444 <__libc_init_array>:
   10444:	ff010113          	addi	sp,sp,-16
   10448:	00812423          	sw	s0,8(sp)
   1044c:	01212023          	sw	s2,0(sp)
   10450:	00012437          	lui	s0,0x12
   10454:	00012937          	lui	s2,0x12
   10458:	89040793          	addi	a5,s0,-1904 # 11890 <__init_array_start>
   1045c:	89090913          	addi	s2,s2,-1904 # 11890 <__init_array_start>
   10460:	40f90933          	sub	s2,s2,a5
   10464:	00112623          	sw	ra,12(sp)
   10468:	00912223          	sw	s1,4(sp)
   1046c:	40295913          	srai	s2,s2,0x2
   10470:	02090063          	beqz	s2,10490 <__libc_init_array+0x4c>
   10474:	89040413          	addi	s0,s0,-1904
   10478:	00000493          	li	s1,0
   1047c:	00042783          	lw	a5,0(s0)
   10480:	00148493          	addi	s1,s1,1
   10484:	00440413          	addi	s0,s0,4
   10488:	000780e7          	jalr	a5
   1048c:	fe9918e3          	bne	s2,s1,1047c <__libc_init_array+0x38>
   10490:	00012437          	lui	s0,0x12
   10494:	00012937          	lui	s2,0x12
   10498:	89040793          	addi	a5,s0,-1904 # 11890 <__init_array_start>
   1049c:	89890913          	addi	s2,s2,-1896 # 11898 <__init_array_end>
   104a0:	40f90933          	sub	s2,s2,a5
   104a4:	40295913          	srai	s2,s2,0x2
   104a8:	02090063          	beqz	s2,104c8 <__libc_init_array+0x84>
   104ac:	89040413          	addi	s0,s0,-1904
   104b0:	00000493          	li	s1,0
   104b4:	00042783          	lw	a5,0(s0)
   104b8:	00148493          	addi	s1,s1,1
   104bc:	00440413          	addi	s0,s0,4
   104c0:	000780e7          	jalr	a5
   104c4:	fe9918e3          	bne	s2,s1,104b4 <__libc_init_array+0x70>
   104c8:	00c12083          	lw	ra,12(sp)
   104cc:	00812403          	lw	s0,8(sp)
   104d0:	00412483          	lw	s1,4(sp)
   104d4:	00012903          	lw	s2,0(sp)
   104d8:	01010113          	addi	sp,sp,16
   104dc:	00008067          	ret

000104e0 <memset>:
   104e0:	00f00313          	li	t1,15
   104e4:	00050713          	mv	a4,a0
   104e8:	02c37e63          	bgeu	t1,a2,10524 <memset+0x44>
   104ec:	00f77793          	andi	a5,a4,15
   104f0:	0a079063          	bnez	a5,10590 <memset+0xb0>
   104f4:	08059263          	bnez	a1,10578 <memset+0x98>
   104f8:	ff067693          	andi	a3,a2,-16
   104fc:	00f67613          	andi	a2,a2,15
   10500:	00e686b3          	add	a3,a3,a4
   10504:	00b72023          	sw	a1,0(a4)
   10508:	00b72223          	sw	a1,4(a4)
   1050c:	00b72423          	sw	a1,8(a4)
   10510:	00b72623          	sw	a1,12(a4)
   10514:	01070713          	addi	a4,a4,16
   10518:	fed766e3          	bltu	a4,a3,10504 <memset+0x24>
   1051c:	00061463          	bnez	a2,10524 <memset+0x44>
   10520:	00008067          	ret
   10524:	40c306b3          	sub	a3,t1,a2
   10528:	00269693          	slli	a3,a3,0x2
   1052c:	00000297          	auipc	t0,0x0
   10530:	005686b3          	add	a3,a3,t0
   10534:	00c68067          	jr	12(a3)
   10538:	00b70723          	sb	a1,14(a4)
   1053c:	00b706a3          	sb	a1,13(a4)
   10540:	00b70623          	sb	a1,12(a4)
   10544:	00b705a3          	sb	a1,11(a4)
   10548:	00b70523          	sb	a1,10(a4)
   1054c:	00b704a3          	sb	a1,9(a4)
   10550:	00b70423          	sb	a1,8(a4)
   10554:	00b703a3          	sb	a1,7(a4)
   10558:	00b70323          	sb	a1,6(a4)
   1055c:	00b702a3          	sb	a1,5(a4)
   10560:	00b70223          	sb	a1,4(a4)
   10564:	00b701a3          	sb	a1,3(a4)
   10568:	00b70123          	sb	a1,2(a4)
   1056c:	00b700a3          	sb	a1,1(a4)
   10570:	00b70023          	sb	a1,0(a4)
   10574:	00008067          	ret
   10578:	0ff5f593          	andi	a1,a1,255
   1057c:	00859693          	slli	a3,a1,0x8
   10580:	00d5e5b3          	or	a1,a1,a3
   10584:	01059693          	slli	a3,a1,0x10
   10588:	00d5e5b3          	or	a1,a1,a3
   1058c:	f6dff06f          	j	104f8 <memset+0x18>
   10590:	00279693          	slli	a3,a5,0x2
   10594:	00000297          	auipc	t0,0x0
   10598:	005686b3          	add	a3,a3,t0
   1059c:	00008293          	mv	t0,ra
   105a0:	fa0680e7          	jalr	-96(a3)
   105a4:	00028093          	mv	ra,t0
   105a8:	ff078793          	addi	a5,a5,-16
   105ac:	40f70733          	sub	a4,a4,a5
   105b0:	00f60633          	add	a2,a2,a5
   105b4:	f6c378e3          	bgeu	t1,a2,10524 <memset+0x44>
   105b8:	f3dff06f          	j	104f4 <memset+0x14>

000105bc <__call_exitprocs>:
   105bc:	fd010113          	addi	sp,sp,-48
   105c0:	01412c23          	sw	s4,24(sp)
   105c4:	c281aa03          	lw	s4,-984(gp) # 11cc8 <_global_impure_ptr>
   105c8:	03212023          	sw	s2,32(sp)
   105cc:	02112623          	sw	ra,44(sp)
   105d0:	148a2903          	lw	s2,328(s4)
   105d4:	02812423          	sw	s0,40(sp)
   105d8:	02912223          	sw	s1,36(sp)
   105dc:	01312e23          	sw	s3,28(sp)
   105e0:	01512a23          	sw	s5,20(sp)
   105e4:	01612823          	sw	s6,16(sp)
   105e8:	01712623          	sw	s7,12(sp)
   105ec:	01812423          	sw	s8,8(sp)
   105f0:	04090063          	beqz	s2,10630 <__call_exitprocs+0x74>
   105f4:	00050b13          	mv	s6,a0
   105f8:	00058b93          	mv	s7,a1
   105fc:	00100a93          	li	s5,1
   10600:	fff00993          	li	s3,-1
   10604:	00492483          	lw	s1,4(s2)
   10608:	fff48413          	addi	s0,s1,-1
   1060c:	02044263          	bltz	s0,10630 <__call_exitprocs+0x74>
   10610:	00249493          	slli	s1,s1,0x2
   10614:	009904b3          	add	s1,s2,s1
   10618:	040b8463          	beqz	s7,10660 <__call_exitprocs+0xa4>
   1061c:	1044a783          	lw	a5,260(s1)
   10620:	05778063          	beq	a5,s7,10660 <__call_exitprocs+0xa4>
   10624:	fff40413          	addi	s0,s0,-1
   10628:	ffc48493          	addi	s1,s1,-4
   1062c:	ff3416e3          	bne	s0,s3,10618 <__call_exitprocs+0x5c>
   10630:	02c12083          	lw	ra,44(sp)
   10634:	02812403          	lw	s0,40(sp)
   10638:	02412483          	lw	s1,36(sp)
   1063c:	02012903          	lw	s2,32(sp)
   10640:	01c12983          	lw	s3,28(sp)
   10644:	01812a03          	lw	s4,24(sp)
   10648:	01412a83          	lw	s5,20(sp)
   1064c:	01012b03          	lw	s6,16(sp)
   10650:	00c12b83          	lw	s7,12(sp)
   10654:	00812c03          	lw	s8,8(sp)
   10658:	03010113          	addi	sp,sp,48
   1065c:	00008067          	ret
   10660:	00492783          	lw	a5,4(s2)
   10664:	0044a683          	lw	a3,4(s1)
   10668:	fff78793          	addi	a5,a5,-1
   1066c:	04878e63          	beq	a5,s0,106c8 <__call_exitprocs+0x10c>
   10670:	0004a223          	sw	zero,4(s1)
   10674:	fa0688e3          	beqz	a3,10624 <__call_exitprocs+0x68>
   10678:	18892783          	lw	a5,392(s2)
   1067c:	008a9733          	sll	a4,s5,s0
   10680:	00492c03          	lw	s8,4(s2)
   10684:	00f777b3          	and	a5,a4,a5
   10688:	02079263          	bnez	a5,106ac <__call_exitprocs+0xf0>
   1068c:	000680e7          	jalr	a3
   10690:	00492703          	lw	a4,4(s2)
   10694:	148a2783          	lw	a5,328(s4)
   10698:	01871463          	bne	a4,s8,106a0 <__call_exitprocs+0xe4>
   1069c:	f8f904e3          	beq	s2,a5,10624 <__call_exitprocs+0x68>
   106a0:	f80788e3          	beqz	a5,10630 <__call_exitprocs+0x74>
   106a4:	00078913          	mv	s2,a5
   106a8:	f5dff06f          	j	10604 <__call_exitprocs+0x48>
   106ac:	18c92783          	lw	a5,396(s2)
   106b0:	0844a583          	lw	a1,132(s1)
   106b4:	00f77733          	and	a4,a4,a5
   106b8:	00071c63          	bnez	a4,106d0 <__call_exitprocs+0x114>
   106bc:	000b0513          	mv	a0,s6
   106c0:	000680e7          	jalr	a3
   106c4:	fcdff06f          	j	10690 <__call_exitprocs+0xd4>
   106c8:	00892223          	sw	s0,4(s2)
   106cc:	fa9ff06f          	j	10674 <__call_exitprocs+0xb8>
   106d0:	00058513          	mv	a0,a1
   106d4:	000680e7          	jalr	a3
   106d8:	fb9ff06f          	j	10690 <__call_exitprocs+0xd4>

000106dc <__libc_fini_array>:
   106dc:	ff010113          	addi	sp,sp,-16
   106e0:	00812423          	sw	s0,8(sp)
   106e4:	000127b7          	lui	a5,0x12
   106e8:	00012437          	lui	s0,0x12
   106ec:	89840413          	addi	s0,s0,-1896 # 11898 <__init_array_end>
   106f0:	89c78793          	addi	a5,a5,-1892 # 1189c <__fini_array_end>
   106f4:	408787b3          	sub	a5,a5,s0
   106f8:	00912223          	sw	s1,4(sp)
   106fc:	00112623          	sw	ra,12(sp)
   10700:	4027d493          	srai	s1,a5,0x2
   10704:	02048063          	beqz	s1,10724 <__libc_fini_array+0x48>
   10708:	ffc78793          	addi	a5,a5,-4
   1070c:	00878433          	add	s0,a5,s0
   10710:	00042783          	lw	a5,0(s0)
   10714:	fff48493          	addi	s1,s1,-1
   10718:	ffc40413          	addi	s0,s0,-4
   1071c:	000780e7          	jalr	a5
   10720:	fe0498e3          	bnez	s1,10710 <__libc_fini_array+0x34>
   10724:	00c12083          	lw	ra,12(sp)
   10728:	00812403          	lw	s0,8(sp)
   1072c:	00412483          	lw	s1,4(sp)
   10730:	01010113          	addi	sp,sp,16
   10734:	00008067          	ret

00010738 <atexit>:
   10738:	00050593          	mv	a1,a0
   1073c:	00000693          	li	a3,0
   10740:	00000613          	li	a2,0
   10744:	00000513          	li	a0,0
   10748:	0040006f          	j	1074c <__register_exitproc>

0001074c <__register_exitproc>:
   1074c:	c281a703          	lw	a4,-984(gp) # 11cc8 <_global_impure_ptr>
   10750:	14872783          	lw	a5,328(a4)
   10754:	04078c63          	beqz	a5,107ac <__register_exitproc+0x60>
   10758:	0047a703          	lw	a4,4(a5)
   1075c:	01f00813          	li	a6,31
   10760:	06e84e63          	blt	a6,a4,107dc <__register_exitproc+0x90>
   10764:	00271813          	slli	a6,a4,0x2
   10768:	02050663          	beqz	a0,10794 <__register_exitproc+0x48>
   1076c:	01078333          	add	t1,a5,a6
   10770:	08c32423          	sw	a2,136(t1) # 101cc <main+0x7c>
   10774:	1887a883          	lw	a7,392(a5)
   10778:	00100613          	li	a2,1
   1077c:	00e61633          	sll	a2,a2,a4
   10780:	00c8e8b3          	or	a7,a7,a2
   10784:	1917a423          	sw	a7,392(a5)
   10788:	10d32423          	sw	a3,264(t1)
   1078c:	00200693          	li	a3,2
   10790:	02d50463          	beq	a0,a3,107b8 <__register_exitproc+0x6c>
   10794:	00170713          	addi	a4,a4,1
   10798:	00e7a223          	sw	a4,4(a5)
   1079c:	010787b3          	add	a5,a5,a6
   107a0:	00b7a423          	sw	a1,8(a5)
   107a4:	00000513          	li	a0,0
   107a8:	00008067          	ret
   107ac:	14c70793          	addi	a5,a4,332
   107b0:	14f72423          	sw	a5,328(a4)
   107b4:	fa5ff06f          	j	10758 <__register_exitproc+0xc>
   107b8:	18c7a683          	lw	a3,396(a5)
   107bc:	00170713          	addi	a4,a4,1
   107c0:	00e7a223          	sw	a4,4(a5)
   107c4:	00c6e633          	or	a2,a3,a2
   107c8:	18c7a623          	sw	a2,396(a5)
   107cc:	010787b3          	add	a5,a5,a6
   107d0:	00b7a423          	sw	a1,8(a5)
   107d4:	00000513          	li	a0,0
   107d8:	00008067          	ret
   107dc:	fff00513          	li	a0,-1
   107e0:	00008067          	ret

000107e4 <_exit>:
   107e4:	00000593          	li	a1,0
   107e8:	00000613          	li	a2,0
   107ec:	00000693          	li	a3,0
   107f0:	00000713          	li	a4,0
   107f4:	00000793          	li	a5,0
   107f8:	05d00893          	li	a7,93
   107fc:	00000073          	ecall
   10800:	00054463          	bltz	a0,10808 <_exit+0x24>
   10804:	0000006f          	j	10804 <_exit+0x20>
   10808:	ff010113          	addi	sp,sp,-16
   1080c:	00812423          	sw	s0,8(sp)
   10810:	00050413          	mv	s0,a0
   10814:	00112623          	sw	ra,12(sp)
   10818:	40800433          	neg	s0,s0
   1081c:	00c000ef          	jal	ra,10828 <__errno>
   10820:	00852023          	sw	s0,0(a0)
   10824:	0000006f          	j	10824 <_exit+0x40>

00010828 <__errno>:
   10828:	c301a503          	lw	a0,-976(gp) # 11cd0 <_impure_ptr>
   1082c:	00008067          	ret

Disassembly of section .rodata:

00010830 <.rodata>:
   10830:	7245                	lui	tp,0xffff1
   10832:	6f72                	flw	ft10,28(sp)
   10834:	2c72                	fld	fs8,280(sp)
   10836:	6620                	flw	fs0,72(a2)
   10838:	2031                	jal	10844 <__errno+0x1c>
   1083a:	7369                	lui	t1,0xffffa
   1083c:	6620                	flw	fs0,72(a2)
   1083e:	6c61                	lui	s8,0x18
   10840:	202c6573          	csrrsi	a0,hedeleg,24
   10844:	73206577          	0x73206577
   10848:	6f68                	flw	fa0,92(a4)
   1084a:	6c75                	lui	s8,0x1d
   1084c:	2064                	fld	fs1,192(s0)
   1084e:	6f6e                	flw	ft10,216(sp)
   10850:	2074                	fld	fa3,192(s0)
   10852:	68206f67          	0x68206f67
   10856:	7265                	lui	tp,0xffff9
   10858:	2165                	jal	10d00 <__errno+0x4d8>
   1085a:	000a                	c.slli	zero,0x2
   1085c:	6559                	lui	a0,0x16
   1085e:	66202c73          	csrr	s8,0x662
   10862:	2032                	fld	ft0,264(sp)
   10864:	7369                	lui	t1,0xffffa
   10866:	7420                	flw	fs0,104(s0)
   10868:	7572                	flw	fa0,60(sp)
   1086a:	0a65                	addi	s4,s4,25
   1086c:	0000                	unimp
   1086e:	0000                	unimp
   10870:	5b61                	li	s6,-8
   10872:	5d35                	li	s10,-19
   10874:	3d20                	fld	fs0,120(a0)
   10876:	0020                	addi	s0,sp,8
   10878:	0001                	nop
   1087a:	0000                	unimp
   1087c:	0002                	c.slli64	zero
   1087e:	0000                	unimp
   10880:	00000003          	lb	zero,0(zero) # 0 <register_fini-0x10074>
   10884:	0004                	0x4
   10886:	0000                	unimp
   10888:	0005                	c.nop	1
	...

Disassembly of section .eh_frame:

0001188c <__FRAME_END__>:
   1188c:	0000                	unimp
	...

Disassembly of section .init_array:

00011890 <__init_array_start>:
   11890:	0074                	addi	a3,sp,12
   11892:	0001                	nop

00011894 <__frame_dummy_init_array_entry>:
   11894:	012c                	addi	a1,sp,136
   11896:	0001                	nop

Disassembly of section .fini_array:

00011898 <__do_global_dtors_aux_fini_array_entry>:
   11898:	00dc                	addi	a5,sp,68
   1189a:	0001                	nop

Disassembly of section .data:

000118a0 <__DATA_BEGIN__>:
   118a0:	0000                	unimp
   118a2:	0000                	unimp
   118a4:	1b8c                	addi	a1,sp,496
   118a6:	0001                	nop
   118a8:	1bf4                	addi	a3,sp,508
   118aa:	0001                	nop
   118ac:	1c5c                	addi	a5,sp,564
   118ae:	0001                	nop
	...
   11948:	0001                	nop
   1194a:	0000                	unimp
   1194c:	0000                	unimp
   1194e:	0000                	unimp
   11950:	330e                	fld	ft6,224(sp)
   11952:	abcd                	j	11f44 <__BSS_END__+0x254>
   11954:	1234                	addi	a3,sp,296
   11956:	e66d                	bnez	a2,11a40 <__DATA_BEGIN__+0x1a0>
   11958:	deec                	sw	a1,124(a3)
   1195a:	0005                	c.nop	1
   1195c:	0000000b          	0xb
	...

Disassembly of section .sdata:

00011cc8 <_global_impure_ptr>:
   11cc8:	18a0                	addi	s0,sp,120
   11cca:	0001                	nop

00011ccc <__dso_handle>:
   11ccc:	0000                	unimp
	...

00011cd0 <_impure_ptr>:
   11cd0:	18a0                	addi	s0,sp,120
   11cd2:	0001                	nop

Disassembly of section .bss:

00011cd4 <__bss_start>:
   11cd4:	0000                	unimp
	...

00011cd8 <object.5495>:
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
