
32riscv-elf/quicksort.riscv:     file format elf32-littleriscv


Disassembly of section .text:

00010074 <register_fini>:
   10074:	000007b7          	lui	a5,0x0
   10078:	00078793          	mv	a5,a5
   1007c:	00078863          	beqz	a5,1008c <register_fini+0x18>
   10080:	00011537          	lui	a0,0x11
   10084:	96850513          	addi	a0,a0,-1688 # 10968 <__libc_fini_array>
   10088:	13d0006f          	j	109c4 <atexit>
   1008c:	00008067          	ret

00010090 <_start>:
   10090:	00002197          	auipc	gp,0x2
   10094:	2a018193          	addi	gp,gp,672 # 12330 <__global_pointer$>
   10098:	c3418513          	addi	a0,gp,-972 # 11f64 <_edata>
   1009c:	c5018613          	addi	a2,gp,-944 # 11f80 <__BSS_END__>
   100a0:	40a60633          	sub	a2,a2,a0
   100a4:	00000593          	li	a1,0
   100a8:	6c4000ef          	jal	ra,1076c <memset>
   100ac:	00001517          	auipc	a0,0x1
   100b0:	91850513          	addi	a0,a0,-1768 # 109c4 <atexit>
   100b4:	00050863          	beqz	a0,100c4 <_start+0x34>
   100b8:	00001517          	auipc	a0,0x1
   100bc:	8b050513          	addi	a0,a0,-1872 # 10968 <__libc_fini_array>
   100c0:	105000ef          	jal	ra,109c4 <atexit>
   100c4:	60c000ef          	jal	ra,106d0 <__libc_init_array>
   100c8:	00012503          	lw	a0,0(sp)
   100cc:	00410593          	addi	a1,sp,4
   100d0:	00000613          	li	a2,0
   100d4:	234000ef          	jal	ra,10308 <main>
   100d8:	5c80006f          	j	106a0 <exit>

000100dc <__do_global_dtors_aux>:
   100dc:	c341c703          	lbu	a4,-972(gp) # 11f64 <_edata>
   100e0:	04071463          	bnez	a4,10128 <__do_global_dtors_aux+0x4c>
   100e4:	ff010113          	addi	sp,sp,-16
   100e8:	00812423          	sw	s0,8(sp)
   100ec:	00078413          	mv	s0,a5
   100f0:	000007b7          	lui	a5,0x0
   100f4:	00112623          	sw	ra,12(sp)
   100f8:	00078793          	mv	a5,a5
   100fc:	00078a63          	beqz	a5,10110 <__do_global_dtors_aux+0x34>
   10100:	00012537          	lui	a0,0x12
   10104:	b1c50513          	addi	a0,a0,-1252 # 11b1c <__FRAME_END__>
   10108:	00000097          	auipc	ra,0x0
   1010c:	000000e7          	jalr	zero # 0 <register_fini-0x10074>
   10110:	00100793          	li	a5,1
   10114:	00c12083          	lw	ra,12(sp)
   10118:	c2f18a23          	sb	a5,-972(gp) # 11f64 <_edata>
   1011c:	00812403          	lw	s0,8(sp)
   10120:	01010113          	addi	sp,sp,16
   10124:	00008067          	ret
   10128:	00008067          	ret

0001012c <frame_dummy>:
   1012c:	000007b7          	lui	a5,0x0
   10130:	00078793          	mv	a5,a5
   10134:	00078c63          	beqz	a5,1014c <frame_dummy+0x20>
   10138:	00012537          	lui	a0,0x12
   1013c:	c3818593          	addi	a1,gp,-968 # 11f68 <object.5495>
   10140:	b1c50513          	addi	a0,a0,-1252 # 11b1c <__FRAME_END__>
   10144:	00000317          	auipc	t1,0x0
   10148:	00000067          	jr	zero # 0 <register_fini-0x10074>
   1014c:	00008067          	ret

00010150 <quicksort>:
   10150:	fd010113          	addi	sp,sp,-48
   10154:	02112623          	sw	ra,44(sp)
   10158:	02812423          	sw	s0,40(sp)
   1015c:	03010413          	addi	s0,sp,48
   10160:	fca42e23          	sw	a0,-36(s0)
   10164:	fcb42c23          	sw	a1,-40(s0)
   10168:	fcc42a23          	sw	a2,-44(s0)
   1016c:	fd842703          	lw	a4,-40(s0)
   10170:	fd442783          	lw	a5,-44(s0)
   10174:	18e7c063          	blt	a5,a4,102f4 <quicksort+0x1a4>
   10178:	fd842783          	lw	a5,-40(s0)
   1017c:	00279793          	slli	a5,a5,0x2
   10180:	fdc42703          	lw	a4,-36(s0)
   10184:	00f707b3          	add	a5,a4,a5
   10188:	0007a783          	lw	a5,0(a5) # 0 <register_fini-0x10074>
   1018c:	fef42223          	sw	a5,-28(s0)
   10190:	fd842783          	lw	a5,-40(s0)
   10194:	fef42623          	sw	a5,-20(s0)
   10198:	fd442783          	lw	a5,-44(s0)
   1019c:	fef42423          	sw	a5,-24(s0)
   101a0:	0d40006f          	j	10274 <quicksort+0x124>
   101a4:	fe842783          	lw	a5,-24(s0)
   101a8:	fff78793          	addi	a5,a5,-1
   101ac:	fef42423          	sw	a5,-24(s0)
   101b0:	fe842783          	lw	a5,-24(s0)
   101b4:	00279793          	slli	a5,a5,0x2
   101b8:	fdc42703          	lw	a4,-36(s0)
   101bc:	00f707b3          	add	a5,a4,a5
   101c0:	0007a783          	lw	a5,0(a5)
   101c4:	fe442703          	lw	a4,-28(s0)
   101c8:	02e7c063          	blt	a5,a4,101e8 <quicksort+0x98>
   101cc:	fec42703          	lw	a4,-20(s0)
   101d0:	fe842783          	lw	a5,-24(s0)
   101d4:	fcf748e3          	blt	a4,a5,101a4 <quicksort+0x54>
   101d8:	0100006f          	j	101e8 <quicksort+0x98>
   101dc:	fec42783          	lw	a5,-20(s0)
   101e0:	00178793          	addi	a5,a5,1
   101e4:	fef42623          	sw	a5,-20(s0)
   101e8:	fec42783          	lw	a5,-20(s0)
   101ec:	00279793          	slli	a5,a5,0x2
   101f0:	fdc42703          	lw	a4,-36(s0)
   101f4:	00f707b3          	add	a5,a4,a5
   101f8:	0007a783          	lw	a5,0(a5)
   101fc:	fe442703          	lw	a4,-28(s0)
   10200:	00f74863          	blt	a4,a5,10210 <quicksort+0xc0>
   10204:	fec42703          	lw	a4,-20(s0)
   10208:	fe842783          	lw	a5,-24(s0)
   1020c:	fcf748e3          	blt	a4,a5,101dc <quicksort+0x8c>
   10210:	fec42703          	lw	a4,-20(s0)
   10214:	fe842783          	lw	a5,-24(s0)
   10218:	04f75e63          	bge	a4,a5,10274 <quicksort+0x124>
   1021c:	fec42783          	lw	a5,-20(s0)
   10220:	00279793          	slli	a5,a5,0x2
   10224:	fdc42703          	lw	a4,-36(s0)
   10228:	00f707b3          	add	a5,a4,a5
   1022c:	0007a783          	lw	a5,0(a5)
   10230:	fef42023          	sw	a5,-32(s0)
   10234:	fe842783          	lw	a5,-24(s0)
   10238:	00279793          	slli	a5,a5,0x2
   1023c:	fdc42703          	lw	a4,-36(s0)
   10240:	00f70733          	add	a4,a4,a5
   10244:	fec42783          	lw	a5,-20(s0)
   10248:	00279793          	slli	a5,a5,0x2
   1024c:	fdc42683          	lw	a3,-36(s0)
   10250:	00f687b3          	add	a5,a3,a5
   10254:	00072703          	lw	a4,0(a4)
   10258:	00e7a023          	sw	a4,0(a5)
   1025c:	fe842783          	lw	a5,-24(s0)
   10260:	00279793          	slli	a5,a5,0x2
   10264:	fdc42703          	lw	a4,-36(s0)
   10268:	00f707b3          	add	a5,a4,a5
   1026c:	fe042703          	lw	a4,-32(s0)
   10270:	00e7a023          	sw	a4,0(a5)
   10274:	fec42703          	lw	a4,-20(s0)
   10278:	fe842783          	lw	a5,-24(s0)
   1027c:	f2f71ae3          	bne	a4,a5,101b0 <quicksort+0x60>
   10280:	fec42783          	lw	a5,-20(s0)
   10284:	00279793          	slli	a5,a5,0x2
   10288:	fdc42703          	lw	a4,-36(s0)
   1028c:	00f70733          	add	a4,a4,a5
   10290:	fd842783          	lw	a5,-40(s0)
   10294:	00279793          	slli	a5,a5,0x2
   10298:	fdc42683          	lw	a3,-36(s0)
   1029c:	00f687b3          	add	a5,a3,a5
   102a0:	00072703          	lw	a4,0(a4)
   102a4:	00e7a023          	sw	a4,0(a5)
   102a8:	fec42783          	lw	a5,-20(s0)
   102ac:	00279793          	slli	a5,a5,0x2
   102b0:	fdc42703          	lw	a4,-36(s0)
   102b4:	00f707b3          	add	a5,a4,a5
   102b8:	fe442703          	lw	a4,-28(s0)
   102bc:	00e7a023          	sw	a4,0(a5)
   102c0:	fec42783          	lw	a5,-20(s0)
   102c4:	fff78793          	addi	a5,a5,-1
   102c8:	00078613          	mv	a2,a5
   102cc:	fd842583          	lw	a1,-40(s0)
   102d0:	fdc42503          	lw	a0,-36(s0)
   102d4:	e7dff0ef          	jal	ra,10150 <quicksort>
   102d8:	fec42783          	lw	a5,-20(s0)
   102dc:	00178793          	addi	a5,a5,1
   102e0:	fd442603          	lw	a2,-44(s0)
   102e4:	00078593          	mv	a1,a5
   102e8:	fdc42503          	lw	a0,-36(s0)
   102ec:	e65ff0ef          	jal	ra,10150 <quicksort>
   102f0:	0080006f          	j	102f8 <quicksort+0x1a8>
   102f4:	00000013          	nop
   102f8:	02c12083          	lw	ra,44(sp)
   102fc:	02812403          	lw	s0,40(sp)
   10300:	03010113          	addi	sp,sp,48
   10304:	00008067          	ret

00010308 <main>:
   10308:	e1010113          	addi	sp,sp,-496
   1030c:	1e112623          	sw	ra,492(sp)
   10310:	1e812423          	sw	s0,488(sp)
   10314:	1f010413          	addi	s0,sp,496
   10318:	00a00793          	li	a5,10
   1031c:	fcf42c23          	sw	a5,-40(s0)
   10320:	000117b7          	lui	a5,0x11
   10324:	af478793          	addi	a5,a5,-1292 # 10af4 <__errno+0x40>
   10328:	0007ae03          	lw	t3,0(a5)
   1032c:	0047a303          	lw	t1,4(a5)
   10330:	0087a883          	lw	a7,8(a5)
   10334:	00c7a803          	lw	a6,12(a5)
   10338:	0107a503          	lw	a0,16(a5)
   1033c:	0147a583          	lw	a1,20(a5)
   10340:	0187a603          	lw	a2,24(a5)
   10344:	01c7a683          	lw	a3,28(a5)
   10348:	0207a703          	lw	a4,32(a5)
   1034c:	0247a783          	lw	a5,36(a5)
   10350:	fbc42623          	sw	t3,-84(s0)
   10354:	fa642823          	sw	t1,-80(s0)
   10358:	fb142a23          	sw	a7,-76(s0)
   1035c:	fb042c23          	sw	a6,-72(s0)
   10360:	faa42e23          	sw	a0,-68(s0)
   10364:	fcb42023          	sw	a1,-64(s0)
   10368:	fcc42223          	sw	a2,-60(s0)
   1036c:	fcd42423          	sw	a3,-56(s0)
   10370:	fce42623          	sw	a4,-52(s0)
   10374:	fcf42823          	sw	a5,-48(s0)
   10378:	000117b7          	lui	a5,0x11
   1037c:	abc78513          	addi	a0,a5,-1348 # 10abc <__errno+0x8>
   10380:	23c000ef          	jal	ra,105bc <print_s>
   10384:	fe042623          	sw	zero,-20(s0)
   10388:	0380006f          	j	103c0 <main+0xb8>
   1038c:	fec42783          	lw	a5,-20(s0)
   10390:	00279793          	slli	a5,a5,0x2
   10394:	ff040713          	addi	a4,s0,-16
   10398:	00f707b3          	add	a5,a4,a5
   1039c:	fbc7a783          	lw	a5,-68(a5)
   103a0:	00078513          	mv	a0,a5
   103a4:	1f0000ef          	jal	ra,10594 <print_d>
   103a8:	000117b7          	lui	a5,0x11
   103ac:	ac878513          	addi	a0,a5,-1336 # 10ac8 <__errno+0x14>
   103b0:	20c000ef          	jal	ra,105bc <print_s>
   103b4:	fec42783          	lw	a5,-20(s0)
   103b8:	00178793          	addi	a5,a5,1
   103bc:	fef42623          	sw	a5,-20(s0)
   103c0:	fec42703          	lw	a4,-20(s0)
   103c4:	fd842783          	lw	a5,-40(s0)
   103c8:	fcf742e3          	blt	a4,a5,1038c <main+0x84>
   103cc:	000117b7          	lui	a5,0x11
   103d0:	acc78513          	addi	a0,a5,-1332 # 10acc <__errno+0x18>
   103d4:	1e8000ef          	jal	ra,105bc <print_s>
   103d8:	000117b7          	lui	a5,0x11
   103dc:	ad078513          	addi	a0,a5,-1328 # 10ad0 <__errno+0x1c>
   103e0:	1dc000ef          	jal	ra,105bc <print_s>
   103e4:	fd842783          	lw	a5,-40(s0)
   103e8:	fff78713          	addi	a4,a5,-1
   103ec:	fac40793          	addi	a5,s0,-84
   103f0:	00070613          	mv	a2,a4
   103f4:	00000593          	li	a1,0
   103f8:	00078513          	mv	a0,a5
   103fc:	d55ff0ef          	jal	ra,10150 <quicksort>
   10400:	fe042423          	sw	zero,-24(s0)
   10404:	0380006f          	j	1043c <main+0x134>
   10408:	fe842783          	lw	a5,-24(s0)
   1040c:	00279793          	slli	a5,a5,0x2
   10410:	ff040713          	addi	a4,s0,-16
   10414:	00f707b3          	add	a5,a4,a5
   10418:	fbc7a783          	lw	a5,-68(a5)
   1041c:	00078513          	mv	a0,a5
   10420:	174000ef          	jal	ra,10594 <print_d>
   10424:	000117b7          	lui	a5,0x11
   10428:	ac878513          	addi	a0,a5,-1336 # 10ac8 <__errno+0x14>
   1042c:	190000ef          	jal	ra,105bc <print_s>
   10430:	fe842783          	lw	a5,-24(s0)
   10434:	00178793          	addi	a5,a5,1
   10438:	fef42423          	sw	a5,-24(s0)
   1043c:	fe842703          	lw	a4,-24(s0)
   10440:	fd842783          	lw	a5,-40(s0)
   10444:	fcf742e3          	blt	a4,a5,10408 <main+0x100>
   10448:	000117b7          	lui	a5,0x11
   1044c:	acc78513          	addi	a0,a5,-1332 # 10acc <__errno+0x18>
   10450:	16c000ef          	jal	ra,105bc <print_s>
   10454:	06400793          	li	a5,100
   10458:	fcf42a23          	sw	a5,-44(s0)
   1045c:	fe042223          	sw	zero,-28(s0)
   10460:	0300006f          	j	10490 <main+0x188>
   10464:	06400713          	li	a4,100
   10468:	fe442783          	lw	a5,-28(s0)
   1046c:	40f70733          	sub	a4,a4,a5
   10470:	fe442783          	lw	a5,-28(s0)
   10474:	00279793          	slli	a5,a5,0x2
   10478:	ff040693          	addi	a3,s0,-16
   1047c:	00f687b3          	add	a5,a3,a5
   10480:	e2e7a623          	sw	a4,-468(a5)
   10484:	fe442783          	lw	a5,-28(s0)
   10488:	00178793          	addi	a5,a5,1
   1048c:	fef42223          	sw	a5,-28(s0)
   10490:	fe442703          	lw	a4,-28(s0)
   10494:	06300793          	li	a5,99
   10498:	fce7d6e3          	bge	a5,a4,10464 <main+0x15c>
   1049c:	000117b7          	lui	a5,0x11
   104a0:	adc78513          	addi	a0,a5,-1316 # 10adc <__errno+0x28>
   104a4:	118000ef          	jal	ra,105bc <print_s>
   104a8:	fe042023          	sw	zero,-32(s0)
   104ac:	0380006f          	j	104e4 <main+0x1dc>
   104b0:	fe042783          	lw	a5,-32(s0)
   104b4:	00279793          	slli	a5,a5,0x2
   104b8:	ff040713          	addi	a4,s0,-16
   104bc:	00f707b3          	add	a5,a4,a5
   104c0:	e2c7a783          	lw	a5,-468(a5)
   104c4:	00078513          	mv	a0,a5
   104c8:	0cc000ef          	jal	ra,10594 <print_d>
   104cc:	000117b7          	lui	a5,0x11
   104d0:	ac878513          	addi	a0,a5,-1336 # 10ac8 <__errno+0x14>
   104d4:	0e8000ef          	jal	ra,105bc <print_s>
   104d8:	fe042783          	lw	a5,-32(s0)
   104dc:	00178793          	addi	a5,a5,1
   104e0:	fef42023          	sw	a5,-32(s0)
   104e4:	fe042703          	lw	a4,-32(s0)
   104e8:	fd442783          	lw	a5,-44(s0)
   104ec:	fcf742e3          	blt	a4,a5,104b0 <main+0x1a8>
   104f0:	000117b7          	lui	a5,0x11
   104f4:	acc78513          	addi	a0,a5,-1332 # 10acc <__errno+0x18>
   104f8:	0c4000ef          	jal	ra,105bc <print_s>
   104fc:	000117b7          	lui	a5,0x11
   10500:	ae878513          	addi	a0,a5,-1304 # 10ae8 <__errno+0x34>
   10504:	0b8000ef          	jal	ra,105bc <print_s>
   10508:	fd442783          	lw	a5,-44(s0)
   1050c:	fff78713          	addi	a4,a5,-1
   10510:	e1c40793          	addi	a5,s0,-484
   10514:	00070613          	mv	a2,a4
   10518:	00000593          	li	a1,0
   1051c:	00078513          	mv	a0,a5
   10520:	c31ff0ef          	jal	ra,10150 <quicksort>
   10524:	fc042e23          	sw	zero,-36(s0)
   10528:	0380006f          	j	10560 <main+0x258>
   1052c:	fdc42783          	lw	a5,-36(s0)
   10530:	00279793          	slli	a5,a5,0x2
   10534:	ff040713          	addi	a4,s0,-16
   10538:	00f707b3          	add	a5,a4,a5
   1053c:	e2c7a783          	lw	a5,-468(a5)
   10540:	00078513          	mv	a0,a5
   10544:	050000ef          	jal	ra,10594 <print_d>
   10548:	000117b7          	lui	a5,0x11
   1054c:	ac878513          	addi	a0,a5,-1336 # 10ac8 <__errno+0x14>
   10550:	06c000ef          	jal	ra,105bc <print_s>
   10554:	fdc42783          	lw	a5,-36(s0)
   10558:	00178793          	addi	a5,a5,1
   1055c:	fcf42e23          	sw	a5,-36(s0)
   10560:	fdc42703          	lw	a4,-36(s0)
   10564:	fd442783          	lw	a5,-44(s0)
   10568:	fcf742e3          	blt	a4,a5,1052c <main+0x224>
   1056c:	000117b7          	lui	a5,0x11
   10570:	acc78513          	addi	a0,a5,-1332 # 10acc <__errno+0x18>
   10574:	048000ef          	jal	ra,105bc <print_s>
   10578:	098000ef          	jal	ra,10610 <exit_proc>
   1057c:	00000793          	li	a5,0
   10580:	00078513          	mv	a0,a5
   10584:	1ec12083          	lw	ra,492(sp)
   10588:	1e812403          	lw	s0,488(sp)
   1058c:	1f010113          	addi	sp,sp,496
   10590:	00008067          	ret

00010594 <print_d>:
   10594:	fe010113          	addi	sp,sp,-32
   10598:	00812e23          	sw	s0,28(sp)
   1059c:	02010413          	addi	s0,sp,32
   105a0:	fea42623          	sw	a0,-20(s0)
   105a4:	00200893          	li	a7,2
   105a8:	00000073          	ecall
   105ac:	00000013          	nop
   105b0:	01c12403          	lw	s0,28(sp)
   105b4:	02010113          	addi	sp,sp,32
   105b8:	00008067          	ret

000105bc <print_s>:
   105bc:	fe010113          	addi	sp,sp,-32
   105c0:	00812e23          	sw	s0,28(sp)
   105c4:	02010413          	addi	s0,sp,32
   105c8:	fea42623          	sw	a0,-20(s0)
   105cc:	00000893          	li	a7,0
   105d0:	00000073          	ecall
   105d4:	00000013          	nop
   105d8:	01c12403          	lw	s0,28(sp)
   105dc:	02010113          	addi	sp,sp,32
   105e0:	00008067          	ret

000105e4 <print_c>:
   105e4:	fe010113          	addi	sp,sp,-32
   105e8:	00812e23          	sw	s0,28(sp)
   105ec:	02010413          	addi	s0,sp,32
   105f0:	00050793          	mv	a5,a0
   105f4:	fef407a3          	sb	a5,-17(s0)
   105f8:	00100893          	li	a7,1
   105fc:	00000073          	ecall
   10600:	00000013          	nop
   10604:	01c12403          	lw	s0,28(sp)
   10608:	02010113          	addi	sp,sp,32
   1060c:	00008067          	ret

00010610 <exit_proc>:
   10610:	ff010113          	addi	sp,sp,-16
   10614:	00812623          	sw	s0,12(sp)
   10618:	01010413          	addi	s0,sp,16
   1061c:	00300893          	li	a7,3
   10620:	00000073          	ecall
   10624:	00000013          	nop
   10628:	00c12403          	lw	s0,12(sp)
   1062c:	01010113          	addi	sp,sp,16
   10630:	00008067          	ret

00010634 <read_char>:
   10634:	fe010113          	addi	sp,sp,-32
   10638:	00812e23          	sw	s0,28(sp)
   1063c:	02010413          	addi	s0,sp,32
   10640:	00400893          	li	a7,4
   10644:	00000073          	ecall
   10648:	00050793          	mv	a5,a0
   1064c:	fef407a3          	sb	a5,-17(s0)
   10650:	fef44783          	lbu	a5,-17(s0)
   10654:	00078513          	mv	a0,a5
   10658:	01c12403          	lw	s0,28(sp)
   1065c:	02010113          	addi	sp,sp,32
   10660:	00008067          	ret

00010664 <read_num>:
   10664:	fe010113          	addi	sp,sp,-32
   10668:	00812e23          	sw	s0,28(sp)
   1066c:	02010413          	addi	s0,sp,32
   10670:	00500893          	li	a7,5
   10674:	00000073          	ecall
   10678:	00050713          	mv	a4,a0
   1067c:	fee42423          	sw	a4,-24(s0)
   10680:	fef42623          	sw	a5,-20(s0)
   10684:	fe842703          	lw	a4,-24(s0)
   10688:	fec42783          	lw	a5,-20(s0)
   1068c:	00070513          	mv	a0,a4
   10690:	00078593          	mv	a1,a5
   10694:	01c12403          	lw	s0,28(sp)
   10698:	02010113          	addi	sp,sp,32
   1069c:	00008067          	ret

000106a0 <exit>:
   106a0:	ff010113          	addi	sp,sp,-16
   106a4:	00000593          	li	a1,0
   106a8:	00812423          	sw	s0,8(sp)
   106ac:	00112623          	sw	ra,12(sp)
   106b0:	00050413          	mv	s0,a0
   106b4:	194000ef          	jal	ra,10848 <__call_exitprocs>
   106b8:	c281a503          	lw	a0,-984(gp) # 11f58 <_global_impure_ptr>
   106bc:	03c52783          	lw	a5,60(a0)
   106c0:	00078463          	beqz	a5,106c8 <exit+0x28>
   106c4:	000780e7          	jalr	a5
   106c8:	00040513          	mv	a0,s0
   106cc:	3a4000ef          	jal	ra,10a70 <_exit>

000106d0 <__libc_init_array>:
   106d0:	ff010113          	addi	sp,sp,-16
   106d4:	00812423          	sw	s0,8(sp)
   106d8:	01212023          	sw	s2,0(sp)
   106dc:	00012437          	lui	s0,0x12
   106e0:	00012937          	lui	s2,0x12
   106e4:	b2040793          	addi	a5,s0,-1248 # 11b20 <__init_array_start>
   106e8:	b2090913          	addi	s2,s2,-1248 # 11b20 <__init_array_start>
   106ec:	40f90933          	sub	s2,s2,a5
   106f0:	00112623          	sw	ra,12(sp)
   106f4:	00912223          	sw	s1,4(sp)
   106f8:	40295913          	srai	s2,s2,0x2
   106fc:	02090063          	beqz	s2,1071c <__libc_init_array+0x4c>
   10700:	b2040413          	addi	s0,s0,-1248
   10704:	00000493          	li	s1,0
   10708:	00042783          	lw	a5,0(s0)
   1070c:	00148493          	addi	s1,s1,1
   10710:	00440413          	addi	s0,s0,4
   10714:	000780e7          	jalr	a5
   10718:	fe9918e3          	bne	s2,s1,10708 <__libc_init_array+0x38>
   1071c:	00012437          	lui	s0,0x12
   10720:	00012937          	lui	s2,0x12
   10724:	b2040793          	addi	a5,s0,-1248 # 11b20 <__init_array_start>
   10728:	b2890913          	addi	s2,s2,-1240 # 11b28 <__init_array_end>
   1072c:	40f90933          	sub	s2,s2,a5
   10730:	40295913          	srai	s2,s2,0x2
   10734:	02090063          	beqz	s2,10754 <__libc_init_array+0x84>
   10738:	b2040413          	addi	s0,s0,-1248
   1073c:	00000493          	li	s1,0
   10740:	00042783          	lw	a5,0(s0)
   10744:	00148493          	addi	s1,s1,1
   10748:	00440413          	addi	s0,s0,4
   1074c:	000780e7          	jalr	a5
   10750:	fe9918e3          	bne	s2,s1,10740 <__libc_init_array+0x70>
   10754:	00c12083          	lw	ra,12(sp)
   10758:	00812403          	lw	s0,8(sp)
   1075c:	00412483          	lw	s1,4(sp)
   10760:	00012903          	lw	s2,0(sp)
   10764:	01010113          	addi	sp,sp,16
   10768:	00008067          	ret

0001076c <memset>:
   1076c:	00f00313          	li	t1,15
   10770:	00050713          	mv	a4,a0
   10774:	02c37e63          	bgeu	t1,a2,107b0 <memset+0x44>
   10778:	00f77793          	andi	a5,a4,15
   1077c:	0a079063          	bnez	a5,1081c <memset+0xb0>
   10780:	08059263          	bnez	a1,10804 <memset+0x98>
   10784:	ff067693          	andi	a3,a2,-16
   10788:	00f67613          	andi	a2,a2,15
   1078c:	00e686b3          	add	a3,a3,a4
   10790:	00b72023          	sw	a1,0(a4)
   10794:	00b72223          	sw	a1,4(a4)
   10798:	00b72423          	sw	a1,8(a4)
   1079c:	00b72623          	sw	a1,12(a4)
   107a0:	01070713          	addi	a4,a4,16
   107a4:	fed766e3          	bltu	a4,a3,10790 <memset+0x24>
   107a8:	00061463          	bnez	a2,107b0 <memset+0x44>
   107ac:	00008067          	ret
   107b0:	40c306b3          	sub	a3,t1,a2
   107b4:	00269693          	slli	a3,a3,0x2
   107b8:	00000297          	auipc	t0,0x0
   107bc:	005686b3          	add	a3,a3,t0
   107c0:	00c68067          	jr	12(a3)
   107c4:	00b70723          	sb	a1,14(a4)
   107c8:	00b706a3          	sb	a1,13(a4)
   107cc:	00b70623          	sb	a1,12(a4)
   107d0:	00b705a3          	sb	a1,11(a4)
   107d4:	00b70523          	sb	a1,10(a4)
   107d8:	00b704a3          	sb	a1,9(a4)
   107dc:	00b70423          	sb	a1,8(a4)
   107e0:	00b703a3          	sb	a1,7(a4)
   107e4:	00b70323          	sb	a1,6(a4)
   107e8:	00b702a3          	sb	a1,5(a4)
   107ec:	00b70223          	sb	a1,4(a4)
   107f0:	00b701a3          	sb	a1,3(a4)
   107f4:	00b70123          	sb	a1,2(a4)
   107f8:	00b700a3          	sb	a1,1(a4)
   107fc:	00b70023          	sb	a1,0(a4)
   10800:	00008067          	ret
   10804:	0ff5f593          	andi	a1,a1,255
   10808:	00859693          	slli	a3,a1,0x8
   1080c:	00d5e5b3          	or	a1,a1,a3
   10810:	01059693          	slli	a3,a1,0x10
   10814:	00d5e5b3          	or	a1,a1,a3
   10818:	f6dff06f          	j	10784 <memset+0x18>
   1081c:	00279693          	slli	a3,a5,0x2
   10820:	00000297          	auipc	t0,0x0
   10824:	005686b3          	add	a3,a3,t0
   10828:	00008293          	mv	t0,ra
   1082c:	fa0680e7          	jalr	-96(a3)
   10830:	00028093          	mv	ra,t0
   10834:	ff078793          	addi	a5,a5,-16
   10838:	40f70733          	sub	a4,a4,a5
   1083c:	00f60633          	add	a2,a2,a5
   10840:	f6c378e3          	bgeu	t1,a2,107b0 <memset+0x44>
   10844:	f3dff06f          	j	10780 <memset+0x14>

00010848 <__call_exitprocs>:
   10848:	fd010113          	addi	sp,sp,-48
   1084c:	01412c23          	sw	s4,24(sp)
   10850:	c281aa03          	lw	s4,-984(gp) # 11f58 <_global_impure_ptr>
   10854:	03212023          	sw	s2,32(sp)
   10858:	02112623          	sw	ra,44(sp)
   1085c:	148a2903          	lw	s2,328(s4)
   10860:	02812423          	sw	s0,40(sp)
   10864:	02912223          	sw	s1,36(sp)
   10868:	01312e23          	sw	s3,28(sp)
   1086c:	01512a23          	sw	s5,20(sp)
   10870:	01612823          	sw	s6,16(sp)
   10874:	01712623          	sw	s7,12(sp)
   10878:	01812423          	sw	s8,8(sp)
   1087c:	04090063          	beqz	s2,108bc <__call_exitprocs+0x74>
   10880:	00050b13          	mv	s6,a0
   10884:	00058b93          	mv	s7,a1
   10888:	00100a93          	li	s5,1
   1088c:	fff00993          	li	s3,-1
   10890:	00492483          	lw	s1,4(s2)
   10894:	fff48413          	addi	s0,s1,-1
   10898:	02044263          	bltz	s0,108bc <__call_exitprocs+0x74>
   1089c:	00249493          	slli	s1,s1,0x2
   108a0:	009904b3          	add	s1,s2,s1
   108a4:	040b8463          	beqz	s7,108ec <__call_exitprocs+0xa4>
   108a8:	1044a783          	lw	a5,260(s1)
   108ac:	05778063          	beq	a5,s7,108ec <__call_exitprocs+0xa4>
   108b0:	fff40413          	addi	s0,s0,-1
   108b4:	ffc48493          	addi	s1,s1,-4
   108b8:	ff3416e3          	bne	s0,s3,108a4 <__call_exitprocs+0x5c>
   108bc:	02c12083          	lw	ra,44(sp)
   108c0:	02812403          	lw	s0,40(sp)
   108c4:	02412483          	lw	s1,36(sp)
   108c8:	02012903          	lw	s2,32(sp)
   108cc:	01c12983          	lw	s3,28(sp)
   108d0:	01812a03          	lw	s4,24(sp)
   108d4:	01412a83          	lw	s5,20(sp)
   108d8:	01012b03          	lw	s6,16(sp)
   108dc:	00c12b83          	lw	s7,12(sp)
   108e0:	00812c03          	lw	s8,8(sp)
   108e4:	03010113          	addi	sp,sp,48
   108e8:	00008067          	ret
   108ec:	00492783          	lw	a5,4(s2)
   108f0:	0044a683          	lw	a3,4(s1)
   108f4:	fff78793          	addi	a5,a5,-1
   108f8:	04878e63          	beq	a5,s0,10954 <__call_exitprocs+0x10c>
   108fc:	0004a223          	sw	zero,4(s1)
   10900:	fa0688e3          	beqz	a3,108b0 <__call_exitprocs+0x68>
   10904:	18892783          	lw	a5,392(s2)
   10908:	008a9733          	sll	a4,s5,s0
   1090c:	00492c03          	lw	s8,4(s2)
   10910:	00f777b3          	and	a5,a4,a5
   10914:	02079263          	bnez	a5,10938 <__call_exitprocs+0xf0>
   10918:	000680e7          	jalr	a3
   1091c:	00492703          	lw	a4,4(s2)
   10920:	148a2783          	lw	a5,328(s4)
   10924:	01871463          	bne	a4,s8,1092c <__call_exitprocs+0xe4>
   10928:	f8f904e3          	beq	s2,a5,108b0 <__call_exitprocs+0x68>
   1092c:	f80788e3          	beqz	a5,108bc <__call_exitprocs+0x74>
   10930:	00078913          	mv	s2,a5
   10934:	f5dff06f          	j	10890 <__call_exitprocs+0x48>
   10938:	18c92783          	lw	a5,396(s2)
   1093c:	0844a583          	lw	a1,132(s1)
   10940:	00f77733          	and	a4,a4,a5
   10944:	00071c63          	bnez	a4,1095c <__call_exitprocs+0x114>
   10948:	000b0513          	mv	a0,s6
   1094c:	000680e7          	jalr	a3
   10950:	fcdff06f          	j	1091c <__call_exitprocs+0xd4>
   10954:	00892223          	sw	s0,4(s2)
   10958:	fa9ff06f          	j	10900 <__call_exitprocs+0xb8>
   1095c:	00058513          	mv	a0,a1
   10960:	000680e7          	jalr	a3
   10964:	fb9ff06f          	j	1091c <__call_exitprocs+0xd4>

00010968 <__libc_fini_array>:
   10968:	ff010113          	addi	sp,sp,-16
   1096c:	00812423          	sw	s0,8(sp)
   10970:	000127b7          	lui	a5,0x12
   10974:	00012437          	lui	s0,0x12
   10978:	b2840413          	addi	s0,s0,-1240 # 11b28 <__init_array_end>
   1097c:	b2c78793          	addi	a5,a5,-1236 # 11b2c <__fini_array_end>
   10980:	408787b3          	sub	a5,a5,s0
   10984:	00912223          	sw	s1,4(sp)
   10988:	00112623          	sw	ra,12(sp)
   1098c:	4027d493          	srai	s1,a5,0x2
   10990:	02048063          	beqz	s1,109b0 <__libc_fini_array+0x48>
   10994:	ffc78793          	addi	a5,a5,-4
   10998:	00878433          	add	s0,a5,s0
   1099c:	00042783          	lw	a5,0(s0)
   109a0:	fff48493          	addi	s1,s1,-1
   109a4:	ffc40413          	addi	s0,s0,-4
   109a8:	000780e7          	jalr	a5
   109ac:	fe0498e3          	bnez	s1,1099c <__libc_fini_array+0x34>
   109b0:	00c12083          	lw	ra,12(sp)
   109b4:	00812403          	lw	s0,8(sp)
   109b8:	00412483          	lw	s1,4(sp)
   109bc:	01010113          	addi	sp,sp,16
   109c0:	00008067          	ret

000109c4 <atexit>:
   109c4:	00050593          	mv	a1,a0
   109c8:	00000693          	li	a3,0
   109cc:	00000613          	li	a2,0
   109d0:	00000513          	li	a0,0
   109d4:	0040006f          	j	109d8 <__register_exitproc>

000109d8 <__register_exitproc>:
   109d8:	c281a703          	lw	a4,-984(gp) # 11f58 <_global_impure_ptr>
   109dc:	14872783          	lw	a5,328(a4)
   109e0:	04078c63          	beqz	a5,10a38 <__register_exitproc+0x60>
   109e4:	0047a703          	lw	a4,4(a5)
   109e8:	01f00813          	li	a6,31
   109ec:	06e84e63          	blt	a6,a4,10a68 <__register_exitproc+0x90>
   109f0:	00271813          	slli	a6,a4,0x2
   109f4:	02050663          	beqz	a0,10a20 <__register_exitproc+0x48>
   109f8:	01078333          	add	t1,a5,a6
   109fc:	08c32423          	sw	a2,136(t1) # 101cc <quicksort+0x7c>
   10a00:	1887a883          	lw	a7,392(a5)
   10a04:	00100613          	li	a2,1
   10a08:	00e61633          	sll	a2,a2,a4
   10a0c:	00c8e8b3          	or	a7,a7,a2
   10a10:	1917a423          	sw	a7,392(a5)
   10a14:	10d32423          	sw	a3,264(t1)
   10a18:	00200693          	li	a3,2
   10a1c:	02d50463          	beq	a0,a3,10a44 <__register_exitproc+0x6c>
   10a20:	00170713          	addi	a4,a4,1
   10a24:	00e7a223          	sw	a4,4(a5)
   10a28:	010787b3          	add	a5,a5,a6
   10a2c:	00b7a423          	sw	a1,8(a5)
   10a30:	00000513          	li	a0,0
   10a34:	00008067          	ret
   10a38:	14c70793          	addi	a5,a4,332
   10a3c:	14f72423          	sw	a5,328(a4)
   10a40:	fa5ff06f          	j	109e4 <__register_exitproc+0xc>
   10a44:	18c7a683          	lw	a3,396(a5)
   10a48:	00170713          	addi	a4,a4,1
   10a4c:	00e7a223          	sw	a4,4(a5)
   10a50:	00c6e633          	or	a2,a3,a2
   10a54:	18c7a623          	sw	a2,396(a5)
   10a58:	010787b3          	add	a5,a5,a6
   10a5c:	00b7a423          	sw	a1,8(a5)
   10a60:	00000513          	li	a0,0
   10a64:	00008067          	ret
   10a68:	fff00513          	li	a0,-1
   10a6c:	00008067          	ret

00010a70 <_exit>:
   10a70:	00000593          	li	a1,0
   10a74:	00000613          	li	a2,0
   10a78:	00000693          	li	a3,0
   10a7c:	00000713          	li	a4,0
   10a80:	00000793          	li	a5,0
   10a84:	05d00893          	li	a7,93
   10a88:	00000073          	ecall
   10a8c:	00054463          	bltz	a0,10a94 <_exit+0x24>
   10a90:	0000006f          	j	10a90 <_exit+0x20>
   10a94:	ff010113          	addi	sp,sp,-16
   10a98:	00812423          	sw	s0,8(sp)
   10a9c:	00050413          	mv	s0,a0
   10aa0:	00112623          	sw	ra,12(sp)
   10aa4:	40800433          	neg	s0,s0
   10aa8:	00c000ef          	jal	ra,10ab4 <__errno>
   10aac:	00852023          	sw	s0,0(a0)
   10ab0:	0000006f          	j	10ab0 <_exit+0x40>

00010ab4 <__errno>:
   10ab4:	c301a503          	lw	a0,-976(gp) # 11f60 <_impure_ptr>
   10ab8:	00008067          	ret

Disassembly of section .rodata:

00010abc <.rodata>:
   10abc:	7250                	flw	fa2,36(a2)
   10abe:	7665                	lui	a2,0xffff9
   10ac0:	4120                	lw	s0,64(a0)
   10ac2:	203a                	fld	ft0,392(sp)
   10ac4:	0000                	unimp
   10ac6:	0000                	unimp
   10ac8:	0020                	addi	s0,sp,8
   10aca:	0000                	unimp
   10acc:	000a                	c.slli	zero,0x2
   10ace:	0000                	unimp
   10ad0:	74726f53          	0x74726f53
   10ad4:	6465                	lui	s0,0x19
   10ad6:	4120                	lw	s0,64(a0)
   10ad8:	203a                	fld	ft0,392(sp)
   10ada:	0000                	unimp
   10adc:	7250                	flw	fa2,36(a2)
   10ade:	7665                	lui	a2,0xffff9
   10ae0:	4220                	lw	s0,64(a2)
   10ae2:	203a                	fld	ft0,392(sp)
   10ae4:	0000                	unimp
   10ae6:	0000                	unimp
   10ae8:	74726f53          	0x74726f53
   10aec:	6465                	lui	s0,0x19
   10aee:	4220                	lw	s0,64(a2)
   10af0:	203a                	fld	ft0,392(sp)
   10af2:	0000                	unimp
   10af4:	0005                	c.nop	1
   10af6:	0000                	unimp
   10af8:	00000003          	lb	zero,0(zero) # 0 <register_fini-0x10074>
   10afc:	0005                	c.nop	1
   10afe:	0000                	unimp
   10b00:	0006                	c.slli	zero,0x1
   10b02:	0000                	unimp
   10b04:	00000007          	0x7
   10b08:	0001                	nop
   10b0a:	0000                	unimp
   10b0c:	00000003          	lb	zero,0(zero) # 0 <register_fini-0x10074>
   10b10:	0005                	c.nop	1
   10b12:	0000                	unimp
   10b14:	0006                	c.slli	zero,0x1
   10b16:	0000                	unimp
   10b18:	0001                	nop
	...

Disassembly of section .eh_frame:

00011b1c <__FRAME_END__>:
   11b1c:	0000                	unimp
	...

Disassembly of section .init_array:

00011b20 <__init_array_start>:
   11b20:	0074                	addi	a3,sp,12
   11b22:	0001                	nop

00011b24 <__frame_dummy_init_array_entry>:
   11b24:	012c                	addi	a1,sp,136
   11b26:	0001                	nop

Disassembly of section .fini_array:

00011b28 <__do_global_dtors_aux_fini_array_entry>:
   11b28:	00dc                	addi	a5,sp,68
   11b2a:	0001                	nop

Disassembly of section .data:

00011b30 <__DATA_BEGIN__>:
   11b30:	0000                	unimp
   11b32:	0000                	unimp
   11b34:	1e1c                	addi	a5,sp,816
   11b36:	0001                	nop
   11b38:	1e84                	addi	s1,sp,880
   11b3a:	0001                	nop
   11b3c:	1eec                	addi	a1,sp,892
   11b3e:	0001                	nop
	...
   11bd8:	0001                	nop
   11bda:	0000                	unimp
   11bdc:	0000                	unimp
   11bde:	0000                	unimp
   11be0:	330e                	fld	ft6,224(sp)
   11be2:	abcd                	j	121d4 <__BSS_END__+0x254>
   11be4:	1234                	addi	a3,sp,296
   11be6:	e66d                	bnez	a2,11cd0 <__DATA_BEGIN__+0x1a0>
   11be8:	deec                	sw	a1,124(a3)
   11bea:	0005                	c.nop	1
   11bec:	0000000b          	0xb
	...

Disassembly of section .sdata:

00011f58 <_global_impure_ptr>:
   11f58:	1b30                	addi	a2,sp,440
   11f5a:	0001                	nop

00011f5c <__dso_handle>:
   11f5c:	0000                	unimp
	...

00011f60 <_impure_ptr>:
   11f60:	1b30                	addi	a2,sp,440
   11f62:	0001                	nop

Disassembly of section .bss:

00011f64 <__bss_start>:
   11f64:	0000                	unimp
	...

00011f68 <object.5495>:
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
