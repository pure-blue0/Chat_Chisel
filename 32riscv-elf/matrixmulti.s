
32riscv-elf/matrixmulti.riscv:     file format elf32-littleriscv


Disassembly of section .text:

00010074 <register_fini>:
   10074:	000007b7          	lui	a5,0x0
   10078:	00078793          	mv	a5,a5
   1007c:	00078863          	beqz	a5,1008c <register_fini+0x18>
   10080:	00011537          	lui	a0,0x11
   10084:	f3450513          	addi	a0,a0,-204 # 10f34 <__libc_fini_array>
   10088:	7090006f          	j	10f90 <atexit>
   1008c:	00008067          	ret

00010090 <_start>:
   10090:	00003197          	auipc	gp,0x3
   10094:	86018193          	addi	gp,gp,-1952 # 128f0 <__global_pointer$>
   10098:	c3818513          	addi	a0,gp,-968 # 12528 <_edata>
   1009c:	c5418613          	addi	a2,gp,-940 # 12544 <__BSS_END__>
   100a0:	40a60633          	sub	a2,a2,a0
   100a4:	00000593          	li	a1,0
   100a8:	491000ef          	jal	ra,10d38 <memset>
   100ac:	00001517          	auipc	a0,0x1
   100b0:	ee450513          	addi	a0,a0,-284 # 10f90 <atexit>
   100b4:	00050863          	beqz	a0,100c4 <_start+0x34>
   100b8:	00001517          	auipc	a0,0x1
   100bc:	e7c50513          	addi	a0,a0,-388 # 10f34 <__libc_fini_array>
   100c0:	6d1000ef          	jal	ra,10f90 <atexit>
   100c4:	3d9000ef          	jal	ra,10c9c <__libc_init_array>
   100c8:	00012503          	lw	a0,0(sp)
   100cc:	00410593          	addi	a1,sp,4
   100d0:	00000613          	li	a2,0
   100d4:	2d4000ef          	jal	ra,103a8 <main>
   100d8:	3950006f          	j	10c6c <exit>

000100dc <__do_global_dtors_aux>:
   100dc:	c381c703          	lbu	a4,-968(gp) # 12528 <_edata>
   100e0:	04071463          	bnez	a4,10128 <__do_global_dtors_aux+0x4c>
   100e4:	ff010113          	addi	sp,sp,-16
   100e8:	00812423          	sw	s0,8(sp)
   100ec:	00078413          	mv	s0,a5
   100f0:	000007b7          	lui	a5,0x0
   100f4:	00112623          	sw	ra,12(sp)
   100f8:	00078793          	mv	a5,a5
   100fc:	00078a63          	beqz	a5,10110 <__do_global_dtors_aux+0x34>
   10100:	00012537          	lui	a0,0x12
   10104:	0dc50513          	addi	a0,a0,220 # 120dc <__FRAME_END__>
   10108:	00000097          	auipc	ra,0x0
   1010c:	000000e7          	jalr	zero # 0 <register_fini-0x10074>
   10110:	00100793          	li	a5,1
   10114:	00c12083          	lw	ra,12(sp)
   10118:	c2f18c23          	sb	a5,-968(gp) # 12528 <_edata>
   1011c:	00812403          	lw	s0,8(sp)
   10120:	01010113          	addi	sp,sp,16
   10124:	00008067          	ret
   10128:	00008067          	ret

0001012c <frame_dummy>:
   1012c:	000007b7          	lui	a5,0x0
   10130:	00078793          	mv	a5,a5
   10134:	00078c63          	beqz	a5,1014c <frame_dummy+0x20>
   10138:	00012537          	lui	a0,0x12
   1013c:	c3c18593          	addi	a1,gp,-964 # 1252c <object.5495>
   10140:	0dc50513          	addi	a0,a0,220 # 120dc <__FRAME_END__>
   10144:	00000317          	auipc	t1,0x0
   10148:	00000067          	jr	zero # 0 <register_fini-0x10074>
   1014c:	00008067          	ret

00010150 <matmulti>:
   10150:	fb010113          	addi	sp,sp,-80
   10154:	04112623          	sw	ra,76(sp)
   10158:	04812423          	sw	s0,72(sp)
   1015c:	04912223          	sw	s1,68(sp)
   10160:	05212023          	sw	s2,64(sp)
   10164:	03312e23          	sw	s3,60(sp)
   10168:	05010413          	addi	s0,sp,80
   1016c:	faa42e23          	sw	a0,-68(s0)
   10170:	fab42c23          	sw	a1,-72(s0)
   10174:	fac42a23          	sw	a2,-76(s0)
   10178:	fad42823          	sw	a3,-80(s0)
   1017c:	00a00693          	li	a3,10
   10180:	fff68693          	addi	a3,a3,-1
   10184:	fcd42e23          	sw	a3,-36(s0)
   10188:	00a00693          	li	a3,10
   1018c:	00068913          	mv	s2,a3
   10190:	00000993          	li	s3,0
   10194:	01b95693          	srli	a3,s2,0x1b
   10198:	00599393          	slli	t2,s3,0x5
   1019c:	0076e3b3          	or	t2,a3,t2
   101a0:	00591313          	slli	t1,s2,0x5
   101a4:	00a00693          	li	a3,10
   101a8:	fff68693          	addi	a3,a3,-1
   101ac:	fcd42623          	sw	a3,-52(s0)
   101b0:	00a00693          	li	a3,10
   101b4:	00068f13          	mv	t5,a3
   101b8:	00000f93          	li	t6,0
   101bc:	01bf5693          	srli	a3,t5,0x1b
   101c0:	005f9893          	slli	a7,t6,0x5
   101c4:	0116e8b3          	or	a7,a3,a7
   101c8:	005f1813          	slli	a6,t5,0x5
   101cc:	00a00693          	li	a3,10
   101d0:	fff68693          	addi	a3,a3,-1
   101d4:	fcd42423          	sw	a3,-56(s0)
   101d8:	00a00693          	li	a3,10
   101dc:	00068e13          	mv	t3,a3
   101e0:	00000e93          	li	t4,0
   101e4:	01be5693          	srli	a3,t3,0x1b
   101e8:	005e9793          	slli	a5,t4,0x5
   101ec:	00f6e7b3          	or	a5,a3,a5
   101f0:	005e1713          	slli	a4,t3,0x5
   101f4:	fc042823          	sw	zero,-48(s0)
   101f8:	1800006f          	j	10378 <matmulti+0x228>
   101fc:	fc042a23          	sw	zero,-44(s0)
   10200:	1600006f          	j	10360 <matmulti+0x210>
   10204:	00a00793          	li	a5,10
   10208:	00078713          	mv	a4,a5
   1020c:	fd042783          	lw	a5,-48(s0)
   10210:	00078593          	mv	a1,a5
   10214:	00070513          	mv	a0,a4
   10218:	1a1000ef          	jal	ra,10bb8 <__mulsi3>
   1021c:	00050793          	mv	a5,a0
   10220:	00279793          	slli	a5,a5,0x2
   10224:	fb442703          	lw	a4,-76(s0)
   10228:	00f70733          	add	a4,a4,a5
   1022c:	fd442783          	lw	a5,-44(s0)
   10230:	00279793          	slli	a5,a5,0x2
   10234:	00f707b3          	add	a5,a4,a5
   10238:	0007a023          	sw	zero,0(a5) # 0 <register_fini-0x10074>
   1023c:	fc042c23          	sw	zero,-40(s0)
   10240:	1080006f          	j	10348 <matmulti+0x1f8>
   10244:	00a00793          	li	a5,10
   10248:	00078713          	mv	a4,a5
   1024c:	fd042783          	lw	a5,-48(s0)
   10250:	00078593          	mv	a1,a5
   10254:	00070513          	mv	a0,a4
   10258:	161000ef          	jal	ra,10bb8 <__mulsi3>
   1025c:	00050793          	mv	a5,a0
   10260:	00279793          	slli	a5,a5,0x2
   10264:	fb442703          	lw	a4,-76(s0)
   10268:	00f70733          	add	a4,a4,a5
   1026c:	fd442783          	lw	a5,-44(s0)
   10270:	00279793          	slli	a5,a5,0x2
   10274:	00f707b3          	add	a5,a4,a5
   10278:	0007a483          	lw	s1,0(a5)
   1027c:	00a00793          	li	a5,10
   10280:	00078713          	mv	a4,a5
   10284:	fd042783          	lw	a5,-48(s0)
   10288:	00078593          	mv	a1,a5
   1028c:	00070513          	mv	a0,a4
   10290:	129000ef          	jal	ra,10bb8 <__mulsi3>
   10294:	00050793          	mv	a5,a0
   10298:	00279793          	slli	a5,a5,0x2
   1029c:	fbc42703          	lw	a4,-68(s0)
   102a0:	00f70733          	add	a4,a4,a5
   102a4:	fd842783          	lw	a5,-40(s0)
   102a8:	00279793          	slli	a5,a5,0x2
   102ac:	00f707b3          	add	a5,a4,a5
   102b0:	0007a903          	lw	s2,0(a5)
   102b4:	00a00793          	li	a5,10
   102b8:	00078713          	mv	a4,a5
   102bc:	fd842783          	lw	a5,-40(s0)
   102c0:	00078593          	mv	a1,a5
   102c4:	00070513          	mv	a0,a4
   102c8:	0f1000ef          	jal	ra,10bb8 <__mulsi3>
   102cc:	00050793          	mv	a5,a0
   102d0:	00279793          	slli	a5,a5,0x2
   102d4:	fb842703          	lw	a4,-72(s0)
   102d8:	00f70733          	add	a4,a4,a5
   102dc:	fd442783          	lw	a5,-44(s0)
   102e0:	00279793          	slli	a5,a5,0x2
   102e4:	00f707b3          	add	a5,a4,a5
   102e8:	0007a783          	lw	a5,0(a5)
   102ec:	00078593          	mv	a1,a5
   102f0:	00090513          	mv	a0,s2
   102f4:	0c5000ef          	jal	ra,10bb8 <__mulsi3>
   102f8:	00050793          	mv	a5,a0
   102fc:	00078913          	mv	s2,a5
   10300:	00a00793          	li	a5,10
   10304:	00078713          	mv	a4,a5
   10308:	fd042783          	lw	a5,-48(s0)
   1030c:	00078593          	mv	a1,a5
   10310:	00070513          	mv	a0,a4
   10314:	0a5000ef          	jal	ra,10bb8 <__mulsi3>
   10318:	00050793          	mv	a5,a0
   1031c:	00279793          	slli	a5,a5,0x2
   10320:	fb442703          	lw	a4,-76(s0)
   10324:	00f706b3          	add	a3,a4,a5
   10328:	01248733          	add	a4,s1,s2
   1032c:	fd442783          	lw	a5,-44(s0)
   10330:	00279793          	slli	a5,a5,0x2
   10334:	00f687b3          	add	a5,a3,a5
   10338:	00e7a023          	sw	a4,0(a5)
   1033c:	fd842783          	lw	a5,-40(s0)
   10340:	00178793          	addi	a5,a5,1
   10344:	fcf42c23          	sw	a5,-40(s0)
   10348:	fd842703          	lw	a4,-40(s0)
   1034c:	fb042783          	lw	a5,-80(s0)
   10350:	eef74ae3          	blt	a4,a5,10244 <matmulti+0xf4>
   10354:	fd442783          	lw	a5,-44(s0)
   10358:	00178793          	addi	a5,a5,1
   1035c:	fcf42a23          	sw	a5,-44(s0)
   10360:	fd442703          	lw	a4,-44(s0)
   10364:	fb042783          	lw	a5,-80(s0)
   10368:	e8f74ee3          	blt	a4,a5,10204 <matmulti+0xb4>
   1036c:	fd042783          	lw	a5,-48(s0)
   10370:	00178793          	addi	a5,a5,1
   10374:	fcf42823          	sw	a5,-48(s0)
   10378:	fd042703          	lw	a4,-48(s0)
   1037c:	fb042783          	lw	a5,-80(s0)
   10380:	e6f74ee3          	blt	a4,a5,101fc <matmulti+0xac>
   10384:	00000013          	nop
   10388:	00000013          	nop
   1038c:	04c12083          	lw	ra,76(sp)
   10390:	04812403          	lw	s0,72(sp)
   10394:	04412483          	lw	s1,68(sp)
   10398:	04012903          	lw	s2,64(sp)
   1039c:	03c12983          	lw	s3,60(sp)
   103a0:	05010113          	addi	sp,sp,80
   103a4:	00008067          	ret

000103a8 <main>:
   103a8:	ef010113          	addi	sp,sp,-272
   103ac:	10112623          	sw	ra,268(sp)
   103b0:	10812423          	sw	s0,264(sp)
   103b4:	10912223          	sw	s1,260(sp)
   103b8:	11212023          	sw	s2,256(sp)
   103bc:	0f312e23          	sw	s3,252(sp)
   103c0:	0f412c23          	sw	s4,248(sp)
   103c4:	0f512a23          	sw	s5,244(sp)
   103c8:	0f612823          	sw	s6,240(sp)
   103cc:	0f712623          	sw	s7,236(sp)
   103d0:	0f812423          	sw	s8,232(sp)
   103d4:	0f912223          	sw	s9,228(sp)
   103d8:	0fa12023          	sw	s10,224(sp)
   103dc:	0db12e23          	sw	s11,220(sp)
   103e0:	11010413          	addi	s0,sp,272
   103e4:	00010793          	mv	a5,sp
   103e8:	f4f42423          	sw	a5,-184(s0)
   103ec:	00a00793          	li	a5,10
   103f0:	fff78793          	addi	a5,a5,-1
   103f4:	faf42c23          	sw	a5,-72(s0)
   103f8:	00a00793          	li	a5,10
   103fc:	00078513          	mv	a0,a5
   10400:	00000593          	li	a1,0
   10404:	01b55793          	srli	a5,a0,0x1b
   10408:	00559693          	slli	a3,a1,0x5
   1040c:	00d7e6b3          	or	a3,a5,a3
   10410:	00551613          	slli	a2,a0,0x5
   10414:	00a00793          	li	a5,10
   10418:	00279793          	slli	a5,a5,0x2
   1041c:	f4f42623          	sw	a5,-180(s0)
   10420:	00a00793          	li	a5,10
   10424:	fff78793          	addi	a5,a5,-1
   10428:	faf42e23          	sw	a5,-68(s0)
   1042c:	00a00793          	li	a5,10
   10430:	00078313          	mv	t1,a5
   10434:	00000393          	li	t2,0
   10438:	00a00793          	li	a5,10
   1043c:	00078813          	mv	a6,a5
   10440:	00000893          	li	a7,0
   10444:	00080613          	mv	a2,a6
   10448:	00088693          	mv	a3,a7
   1044c:	00030513          	mv	a0,t1
   10450:	00038593          	mv	a1,t2
   10454:	788000ef          	jal	ra,10bdc <__muldi3>
   10458:	00050713          	mv	a4,a0
   1045c:	00058793          	mv	a5,a1
   10460:	01b75693          	srli	a3,a4,0x1b
   10464:	00579993          	slli	s3,a5,0x5
   10468:	0136e9b3          	or	s3,a3,s3
   1046c:	00571913          	slli	s2,a4,0x5
   10470:	00a00793          	li	a5,10
   10474:	00078713          	mv	a4,a5
   10478:	00a00793          	li	a5,10
   1047c:	00078593          	mv	a1,a5
   10480:	00070513          	mv	a0,a4
   10484:	734000ef          	jal	ra,10bb8 <__mulsi3>
   10488:	00a00793          	li	a5,10
   1048c:	f4f42023          	sw	a5,-192(s0)
   10490:	f4042223          	sw	zero,-188(s0)
   10494:	00a00793          	li	a5,10
   10498:	f2f42c23          	sw	a5,-200(s0)
   1049c:	f2042e23          	sw	zero,-196(s0)
   104a0:	f3842603          	lw	a2,-200(s0)
   104a4:	f3c42683          	lw	a3,-196(s0)
   104a8:	f4042503          	lw	a0,-192(s0)
   104ac:	f4442583          	lw	a1,-188(s0)
   104b0:	72c000ef          	jal	ra,10bdc <__muldi3>
   104b4:	00050713          	mv	a4,a0
   104b8:	00058793          	mv	a5,a1
   104bc:	01b75693          	srli	a3,a4,0x1b
   104c0:	00579a93          	slli	s5,a5,0x5
   104c4:	0156eab3          	or	s5,a3,s5
   104c8:	00571a13          	slli	s4,a4,0x5
   104cc:	00a00793          	li	a5,10
   104d0:	00078713          	mv	a4,a5
   104d4:	00a00793          	li	a5,10
   104d8:	00078593          	mv	a1,a5
   104dc:	00070513          	mv	a0,a4
   104e0:	6d8000ef          	jal	ra,10bb8 <__mulsi3>
   104e4:	00050793          	mv	a5,a0
   104e8:	00279793          	slli	a5,a5,0x2
   104ec:	00f78793          	addi	a5,a5,15
   104f0:	0047d793          	srli	a5,a5,0x4
   104f4:	00479793          	slli	a5,a5,0x4
   104f8:	40f10133          	sub	sp,sp,a5
   104fc:	00010793          	mv	a5,sp
   10500:	00378793          	addi	a5,a5,3
   10504:	0027d793          	srli	a5,a5,0x2
   10508:	00279793          	slli	a5,a5,0x2
   1050c:	f8f42a23          	sw	a5,-108(s0)
   10510:	00a00793          	li	a5,10
   10514:	fff78793          	addi	a5,a5,-1
   10518:	f8f42823          	sw	a5,-112(s0)
   1051c:	00a00793          	li	a5,10
   10520:	00078c13          	mv	s8,a5
   10524:	00000c93          	li	s9,0
   10528:	01bc5793          	srli	a5,s8,0x1b
   1052c:	005c9b93          	slli	s7,s9,0x5
   10530:	0177ebb3          	or	s7,a5,s7
   10534:	005c1b13          	slli	s6,s8,0x5
   10538:	00a00793          	li	a5,10
   1053c:	00279993          	slli	s3,a5,0x2
   10540:	00a00793          	li	a5,10
   10544:	fff78793          	addi	a5,a5,-1
   10548:	f8f42623          	sw	a5,-116(s0)
   1054c:	00a00793          	li	a5,10
   10550:	f2f42823          	sw	a5,-208(s0)
   10554:	f2042a23          	sw	zero,-204(s0)
   10558:	00a00793          	li	a5,10
   1055c:	f2f42423          	sw	a5,-216(s0)
   10560:	f2042623          	sw	zero,-212(s0)
   10564:	f2842603          	lw	a2,-216(s0)
   10568:	f2c42683          	lw	a3,-212(s0)
   1056c:	f3042503          	lw	a0,-208(s0)
   10570:	f3442583          	lw	a1,-204(s0)
   10574:	668000ef          	jal	ra,10bdc <__muldi3>
   10578:	00050713          	mv	a4,a0
   1057c:	00058793          	mv	a5,a1
   10580:	01b75693          	srli	a3,a4,0x1b
   10584:	00579613          	slli	a2,a5,0x5
   10588:	f6c42623          	sw	a2,-148(s0)
   1058c:	f6c42603          	lw	a2,-148(s0)
   10590:	00c6e6b3          	or	a3,a3,a2
   10594:	f6d42623          	sw	a3,-148(s0)
   10598:	00571793          	slli	a5,a4,0x5
   1059c:	f6f42423          	sw	a5,-152(s0)
   105a0:	00a00793          	li	a5,10
   105a4:	00078713          	mv	a4,a5
   105a8:	00a00793          	li	a5,10
   105ac:	00078593          	mv	a1,a5
   105b0:	00070513          	mv	a0,a4
   105b4:	604000ef          	jal	ra,10bb8 <__mulsi3>
   105b8:	00a00793          	li	a5,10
   105bc:	f2f42023          	sw	a5,-224(s0)
   105c0:	f2042223          	sw	zero,-220(s0)
   105c4:	00a00793          	li	a5,10
   105c8:	f0f42c23          	sw	a5,-232(s0)
   105cc:	f0042e23          	sw	zero,-228(s0)
   105d0:	f1842603          	lw	a2,-232(s0)
   105d4:	f1c42683          	lw	a3,-228(s0)
   105d8:	f2042503          	lw	a0,-224(s0)
   105dc:	f2442583          	lw	a1,-220(s0)
   105e0:	5fc000ef          	jal	ra,10bdc <__muldi3>
   105e4:	00050713          	mv	a4,a0
   105e8:	00058793          	mv	a5,a1
   105ec:	01b75693          	srli	a3,a4,0x1b
   105f0:	00579613          	slli	a2,a5,0x5
   105f4:	f6c42223          	sw	a2,-156(s0)
   105f8:	f6442603          	lw	a2,-156(s0)
   105fc:	00c6e6b3          	or	a3,a3,a2
   10600:	f6d42223          	sw	a3,-156(s0)
   10604:	00571793          	slli	a5,a4,0x5
   10608:	f6f42023          	sw	a5,-160(s0)
   1060c:	00a00793          	li	a5,10
   10610:	00078713          	mv	a4,a5
   10614:	00a00793          	li	a5,10
   10618:	00078593          	mv	a1,a5
   1061c:	00070513          	mv	a0,a4
   10620:	598000ef          	jal	ra,10bb8 <__mulsi3>
   10624:	00050793          	mv	a5,a0
   10628:	00279793          	slli	a5,a5,0x2
   1062c:	00f78793          	addi	a5,a5,15
   10630:	0047d793          	srli	a5,a5,0x4
   10634:	00479793          	slli	a5,a5,0x4
   10638:	40f10133          	sub	sp,sp,a5
   1063c:	00010793          	mv	a5,sp
   10640:	00378793          	addi	a5,a5,3
   10644:	0027d793          	srli	a5,a5,0x2
   10648:	00279793          	slli	a5,a5,0x2
   1064c:	f8f42423          	sw	a5,-120(s0)
   10650:	00a00793          	li	a5,10
   10654:	fff78793          	addi	a5,a5,-1
   10658:	f8f42223          	sw	a5,-124(s0)
   1065c:	00a00793          	li	a5,10
   10660:	f0f42823          	sw	a5,-240(s0)
   10664:	f0042a23          	sw	zero,-236(s0)
   10668:	f1042683          	lw	a3,-240(s0)
   1066c:	f1442703          	lw	a4,-236(s0)
   10670:	00068793          	mv	a5,a3
   10674:	01b7d793          	srli	a5,a5,0x1b
   10678:	00070613          	mv	a2,a4
   1067c:	00561613          	slli	a2,a2,0x5
   10680:	f4c42e23          	sw	a2,-164(s0)
   10684:	f5c42603          	lw	a2,-164(s0)
   10688:	00c7e7b3          	or	a5,a5,a2
   1068c:	f4f42e23          	sw	a5,-164(s0)
   10690:	00068793          	mv	a5,a3
   10694:	00579793          	slli	a5,a5,0x5
   10698:	f4f42c23          	sw	a5,-168(s0)
   1069c:	00a00793          	li	a5,10
   106a0:	00279493          	slli	s1,a5,0x2
   106a4:	00a00793          	li	a5,10
   106a8:	fff78793          	addi	a5,a5,-1
   106ac:	f8f42023          	sw	a5,-128(s0)
   106b0:	00a00793          	li	a5,10
   106b4:	f0f42423          	sw	a5,-248(s0)
   106b8:	f0042623          	sw	zero,-244(s0)
   106bc:	00a00793          	li	a5,10
   106c0:	f0f42023          	sw	a5,-256(s0)
   106c4:	f0042223          	sw	zero,-252(s0)
   106c8:	f0042603          	lw	a2,-256(s0)
   106cc:	f0442683          	lw	a3,-252(s0)
   106d0:	f0842503          	lw	a0,-248(s0)
   106d4:	f0c42583          	lw	a1,-244(s0)
   106d8:	504000ef          	jal	ra,10bdc <__muldi3>
   106dc:	00050713          	mv	a4,a0
   106e0:	00058793          	mv	a5,a1
   106e4:	01b75693          	srli	a3,a4,0x1b
   106e8:	00579613          	slli	a2,a5,0x5
   106ec:	f4c42a23          	sw	a2,-172(s0)
   106f0:	f5442603          	lw	a2,-172(s0)
   106f4:	00c6e6b3          	or	a3,a3,a2
   106f8:	f4d42a23          	sw	a3,-172(s0)
   106fc:	00571793          	slli	a5,a4,0x5
   10700:	f4f42823          	sw	a5,-176(s0)
   10704:	00a00793          	li	a5,10
   10708:	00078713          	mv	a4,a5
   1070c:	00a00793          	li	a5,10
   10710:	00078593          	mv	a1,a5
   10714:	00070513          	mv	a0,a4
   10718:	4a0000ef          	jal	ra,10bb8 <__mulsi3>
   1071c:	00a00793          	li	a5,10
   10720:	eef42c23          	sw	a5,-264(s0)
   10724:	ee042e23          	sw	zero,-260(s0)
   10728:	00a00793          	li	a5,10
   1072c:	eef42823          	sw	a5,-272(s0)
   10730:	ee042a23          	sw	zero,-268(s0)
   10734:	ef042603          	lw	a2,-272(s0)
   10738:	ef442683          	lw	a3,-268(s0)
   1073c:	ef842503          	lw	a0,-264(s0)
   10740:	efc42583          	lw	a1,-260(s0)
   10744:	498000ef          	jal	ra,10bdc <__muldi3>
   10748:	00050713          	mv	a4,a0
   1074c:	00058793          	mv	a5,a1
   10750:	01b75693          	srli	a3,a4,0x1b
   10754:	00579d93          	slli	s11,a5,0x5
   10758:	01b6edb3          	or	s11,a3,s11
   1075c:	00571d13          	slli	s10,a4,0x5
   10760:	00a00793          	li	a5,10
   10764:	00078713          	mv	a4,a5
   10768:	00a00793          	li	a5,10
   1076c:	00078593          	mv	a1,a5
   10770:	00070513          	mv	a0,a4
   10774:	444000ef          	jal	ra,10bb8 <__mulsi3>
   10778:	00050793          	mv	a5,a0
   1077c:	00279793          	slli	a5,a5,0x2
   10780:	00f78793          	addi	a5,a5,15
   10784:	0047d793          	srli	a5,a5,0x4
   10788:	00479793          	slli	a5,a5,0x4
   1078c:	40f10133          	sub	sp,sp,a5
   10790:	00010793          	mv	a5,sp
   10794:	00378793          	addi	a5,a5,3
   10798:	0027d793          	srli	a5,a5,0x2
   1079c:	00279793          	slli	a5,a5,0x2
   107a0:	f6f42e23          	sw	a5,-132(s0)
   107a4:	f8042c23          	sw	zero,-104(s0)
   107a8:	0c00006f          	j	10868 <main+0x4c0>
   107ac:	f8042e23          	sw	zero,-100(s0)
   107b0:	0a00006f          	j	10850 <main+0x4a8>
   107b4:	f4c42783          	lw	a5,-180(s0)
   107b8:	0027d793          	srli	a5,a5,0x2
   107bc:	f9442903          	lw	s2,-108(s0)
   107c0:	f9842583          	lw	a1,-104(s0)
   107c4:	00078513          	mv	a0,a5
   107c8:	3f0000ef          	jal	ra,10bb8 <__mulsi3>
   107cc:	00050713          	mv	a4,a0
   107d0:	f9c42783          	lw	a5,-100(s0)
   107d4:	00f707b3          	add	a5,a4,a5
   107d8:	00279793          	slli	a5,a5,0x2
   107dc:	00f907b3          	add	a5,s2,a5
   107e0:	f9842703          	lw	a4,-104(s0)
   107e4:	00e7a023          	sw	a4,0(a5)
   107e8:	0029d793          	srli	a5,s3,0x2
   107ec:	f8842903          	lw	s2,-120(s0)
   107f0:	f9842583          	lw	a1,-104(s0)
   107f4:	00078513          	mv	a0,a5
   107f8:	3c0000ef          	jal	ra,10bb8 <__mulsi3>
   107fc:	00050713          	mv	a4,a0
   10800:	f9c42783          	lw	a5,-100(s0)
   10804:	00f707b3          	add	a5,a4,a5
   10808:	00279793          	slli	a5,a5,0x2
   1080c:	00f907b3          	add	a5,s2,a5
   10810:	f9c42703          	lw	a4,-100(s0)
   10814:	00e7a023          	sw	a4,0(a5)
   10818:	0024d793          	srli	a5,s1,0x2
   1081c:	f7c42903          	lw	s2,-132(s0)
   10820:	f9842583          	lw	a1,-104(s0)
   10824:	00078513          	mv	a0,a5
   10828:	390000ef          	jal	ra,10bb8 <__mulsi3>
   1082c:	00050713          	mv	a4,a0
   10830:	f9c42783          	lw	a5,-100(s0)
   10834:	00f707b3          	add	a5,a4,a5
   10838:	00279793          	slli	a5,a5,0x2
   1083c:	00f907b3          	add	a5,s2,a5
   10840:	0007a023          	sw	zero,0(a5)
   10844:	f9c42783          	lw	a5,-100(s0)
   10848:	00178793          	addi	a5,a5,1
   1084c:	f8f42e23          	sw	a5,-100(s0)
   10850:	00a00793          	li	a5,10
   10854:	f9c42703          	lw	a4,-100(s0)
   10858:	f4f74ee3          	blt	a4,a5,107b4 <main+0x40c>
   1085c:	f9842783          	lw	a5,-104(s0)
   10860:	00178793          	addi	a5,a5,1
   10864:	f8f42c23          	sw	a5,-104(s0)
   10868:	00a00793          	li	a5,10
   1086c:	f9842703          	lw	a4,-104(s0)
   10870:	f2f74ee3          	blt	a4,a5,107ac <main+0x404>
   10874:	000117b7          	lui	a5,0x11
   10878:	08878513          	addi	a0,a5,136 # 11088 <__errno+0x8>
   1087c:	258000ef          	jal	ra,10ad4 <print_s>
   10880:	fa042023          	sw	zero,-96(s0)
   10884:	0800006f          	j	10904 <main+0x55c>
   10888:	fa042223          	sw	zero,-92(s0)
   1088c:	0540006f          	j	108e0 <main+0x538>
   10890:	f4c42783          	lw	a5,-180(s0)
   10894:	0027d793          	srli	a5,a5,0x2
   10898:	f9442903          	lw	s2,-108(s0)
   1089c:	fa042583          	lw	a1,-96(s0)
   108a0:	00078513          	mv	a0,a5
   108a4:	314000ef          	jal	ra,10bb8 <__mulsi3>
   108a8:	00050713          	mv	a4,a0
   108ac:	fa442783          	lw	a5,-92(s0)
   108b0:	00f707b3          	add	a5,a4,a5
   108b4:	00279793          	slli	a5,a5,0x2
   108b8:	00f907b3          	add	a5,s2,a5
   108bc:	0007a783          	lw	a5,0(a5)
   108c0:	00078513          	mv	a0,a5
   108c4:	1e8000ef          	jal	ra,10aac <print_d>
   108c8:	000117b7          	lui	a5,0x11
   108cc:	0a078513          	addi	a0,a5,160 # 110a0 <__errno+0x20>
   108d0:	204000ef          	jal	ra,10ad4 <print_s>
   108d4:	fa442783          	lw	a5,-92(s0)
   108d8:	00178793          	addi	a5,a5,1
   108dc:	faf42223          	sw	a5,-92(s0)
   108e0:	00a00793          	li	a5,10
   108e4:	fa442703          	lw	a4,-92(s0)
   108e8:	faf744e3          	blt	a4,a5,10890 <main+0x4e8>
   108ec:	000117b7          	lui	a5,0x11
   108f0:	0a478513          	addi	a0,a5,164 # 110a4 <__errno+0x24>
   108f4:	1e0000ef          	jal	ra,10ad4 <print_s>
   108f8:	fa042783          	lw	a5,-96(s0)
   108fc:	00178793          	addi	a5,a5,1
   10900:	faf42023          	sw	a5,-96(s0)
   10904:	00a00793          	li	a5,10
   10908:	fa042703          	lw	a4,-96(s0)
   1090c:	f6f74ee3          	blt	a4,a5,10888 <main+0x4e0>
   10910:	000117b7          	lui	a5,0x11
   10914:	0a878513          	addi	a0,a5,168 # 110a8 <__errno+0x28>
   10918:	1bc000ef          	jal	ra,10ad4 <print_s>
   1091c:	fa042423          	sw	zero,-88(s0)
   10920:	07c0006f          	j	1099c <main+0x5f4>
   10924:	fa042623          	sw	zero,-84(s0)
   10928:	0500006f          	j	10978 <main+0x5d0>
   1092c:	0029d793          	srli	a5,s3,0x2
   10930:	f8842903          	lw	s2,-120(s0)
   10934:	fa842583          	lw	a1,-88(s0)
   10938:	00078513          	mv	a0,a5
   1093c:	27c000ef          	jal	ra,10bb8 <__mulsi3>
   10940:	00050713          	mv	a4,a0
   10944:	fac42783          	lw	a5,-84(s0)
   10948:	00f707b3          	add	a5,a4,a5
   1094c:	00279793          	slli	a5,a5,0x2
   10950:	00f907b3          	add	a5,s2,a5
   10954:	0007a783          	lw	a5,0(a5)
   10958:	00078513          	mv	a0,a5
   1095c:	150000ef          	jal	ra,10aac <print_d>
   10960:	000117b7          	lui	a5,0x11
   10964:	0a078513          	addi	a0,a5,160 # 110a0 <__errno+0x20>
   10968:	16c000ef          	jal	ra,10ad4 <print_s>
   1096c:	fac42783          	lw	a5,-84(s0)
   10970:	00178793          	addi	a5,a5,1
   10974:	faf42623          	sw	a5,-84(s0)
   10978:	00a00793          	li	a5,10
   1097c:	fac42703          	lw	a4,-84(s0)
   10980:	faf746e3          	blt	a4,a5,1092c <main+0x584>
   10984:	000117b7          	lui	a5,0x11
   10988:	0a478513          	addi	a0,a5,164 # 110a4 <__errno+0x24>
   1098c:	148000ef          	jal	ra,10ad4 <print_s>
   10990:	fa842783          	lw	a5,-88(s0)
   10994:	00178793          	addi	a5,a5,1
   10998:	faf42423          	sw	a5,-88(s0)
   1099c:	00a00793          	li	a5,10
   109a0:	fa842703          	lw	a4,-88(s0)
   109a4:	f8f740e3          	blt	a4,a5,10924 <main+0x57c>
   109a8:	f9442783          	lw	a5,-108(s0)
   109ac:	f8842703          	lw	a4,-120(s0)
   109b0:	f7c42603          	lw	a2,-132(s0)
   109b4:	00a00693          	li	a3,10
   109b8:	00070593          	mv	a1,a4
   109bc:	00078513          	mv	a0,a5
   109c0:	f90ff0ef          	jal	ra,10150 <matmulti>
   109c4:	000117b7          	lui	a5,0x11
   109c8:	0c078513          	addi	a0,a5,192 # 110c0 <__errno+0x40>
   109cc:	108000ef          	jal	ra,10ad4 <print_s>
   109d0:	fa042823          	sw	zero,-80(s0)
   109d4:	07c0006f          	j	10a50 <main+0x6a8>
   109d8:	fa042a23          	sw	zero,-76(s0)
   109dc:	0500006f          	j	10a2c <main+0x684>
   109e0:	0024d793          	srli	a5,s1,0x2
   109e4:	f7c42903          	lw	s2,-132(s0)
   109e8:	fb042583          	lw	a1,-80(s0)
   109ec:	00078513          	mv	a0,a5
   109f0:	1c8000ef          	jal	ra,10bb8 <__mulsi3>
   109f4:	00050713          	mv	a4,a0
   109f8:	fb442783          	lw	a5,-76(s0)
   109fc:	00f707b3          	add	a5,a4,a5
   10a00:	00279793          	slli	a5,a5,0x2
   10a04:	00f907b3          	add	a5,s2,a5
   10a08:	0007a783          	lw	a5,0(a5)
   10a0c:	00078513          	mv	a0,a5
   10a10:	09c000ef          	jal	ra,10aac <print_d>
   10a14:	000117b7          	lui	a5,0x11
   10a18:	0a078513          	addi	a0,a5,160 # 110a0 <__errno+0x20>
   10a1c:	0b8000ef          	jal	ra,10ad4 <print_s>
   10a20:	fb442783          	lw	a5,-76(s0)
   10a24:	00178793          	addi	a5,a5,1
   10a28:	faf42a23          	sw	a5,-76(s0)
   10a2c:	00a00793          	li	a5,10
   10a30:	fb442703          	lw	a4,-76(s0)
   10a34:	faf746e3          	blt	a4,a5,109e0 <main+0x638>
   10a38:	000117b7          	lui	a5,0x11
   10a3c:	0a478513          	addi	a0,a5,164 # 110a4 <__errno+0x24>
   10a40:	094000ef          	jal	ra,10ad4 <print_s>
   10a44:	fb042783          	lw	a5,-80(s0)
   10a48:	00178793          	addi	a5,a5,1
   10a4c:	faf42823          	sw	a5,-80(s0)
   10a50:	00a00793          	li	a5,10
   10a54:	fb042703          	lw	a4,-80(s0)
   10a58:	f8f740e3          	blt	a4,a5,109d8 <main+0x630>
   10a5c:	0cc000ef          	jal	ra,10b28 <exit_proc>
   10a60:	f4842103          	lw	sp,-184(s0)
   10a64:	00000793          	li	a5,0
   10a68:	00078513          	mv	a0,a5
   10a6c:	ef040113          	addi	sp,s0,-272
   10a70:	10c12083          	lw	ra,268(sp)
   10a74:	10812403          	lw	s0,264(sp)
   10a78:	10412483          	lw	s1,260(sp)
   10a7c:	10012903          	lw	s2,256(sp)
   10a80:	0fc12983          	lw	s3,252(sp)
   10a84:	0f812a03          	lw	s4,248(sp)
   10a88:	0f412a83          	lw	s5,244(sp)
   10a8c:	0f012b03          	lw	s6,240(sp)
   10a90:	0ec12b83          	lw	s7,236(sp)
   10a94:	0e812c03          	lw	s8,232(sp)
   10a98:	0e412c83          	lw	s9,228(sp)
   10a9c:	0e012d03          	lw	s10,224(sp)
   10aa0:	0dc12d83          	lw	s11,220(sp)
   10aa4:	11010113          	addi	sp,sp,272
   10aa8:	00008067          	ret

00010aac <print_d>:
   10aac:	fe010113          	addi	sp,sp,-32
   10ab0:	00812e23          	sw	s0,28(sp)
   10ab4:	02010413          	addi	s0,sp,32
   10ab8:	fea42623          	sw	a0,-20(s0)
   10abc:	00200893          	li	a7,2
   10ac0:	00000073          	ecall
   10ac4:	00000013          	nop
   10ac8:	01c12403          	lw	s0,28(sp)
   10acc:	02010113          	addi	sp,sp,32
   10ad0:	00008067          	ret

00010ad4 <print_s>:
   10ad4:	fe010113          	addi	sp,sp,-32
   10ad8:	00812e23          	sw	s0,28(sp)
   10adc:	02010413          	addi	s0,sp,32
   10ae0:	fea42623          	sw	a0,-20(s0)
   10ae4:	00000893          	li	a7,0
   10ae8:	00000073          	ecall
   10aec:	00000013          	nop
   10af0:	01c12403          	lw	s0,28(sp)
   10af4:	02010113          	addi	sp,sp,32
   10af8:	00008067          	ret

00010afc <print_c>:
   10afc:	fe010113          	addi	sp,sp,-32
   10b00:	00812e23          	sw	s0,28(sp)
   10b04:	02010413          	addi	s0,sp,32
   10b08:	00050793          	mv	a5,a0
   10b0c:	fef407a3          	sb	a5,-17(s0)
   10b10:	00100893          	li	a7,1
   10b14:	00000073          	ecall
   10b18:	00000013          	nop
   10b1c:	01c12403          	lw	s0,28(sp)
   10b20:	02010113          	addi	sp,sp,32
   10b24:	00008067          	ret

00010b28 <exit_proc>:
   10b28:	ff010113          	addi	sp,sp,-16
   10b2c:	00812623          	sw	s0,12(sp)
   10b30:	01010413          	addi	s0,sp,16
   10b34:	00300893          	li	a7,3
   10b38:	00000073          	ecall
   10b3c:	00000013          	nop
   10b40:	00c12403          	lw	s0,12(sp)
   10b44:	01010113          	addi	sp,sp,16
   10b48:	00008067          	ret

00010b4c <read_char>:
   10b4c:	fe010113          	addi	sp,sp,-32
   10b50:	00812e23          	sw	s0,28(sp)
   10b54:	02010413          	addi	s0,sp,32
   10b58:	00400893          	li	a7,4
   10b5c:	00000073          	ecall
   10b60:	00050793          	mv	a5,a0
   10b64:	fef407a3          	sb	a5,-17(s0)
   10b68:	fef44783          	lbu	a5,-17(s0)
   10b6c:	00078513          	mv	a0,a5
   10b70:	01c12403          	lw	s0,28(sp)
   10b74:	02010113          	addi	sp,sp,32
   10b78:	00008067          	ret

00010b7c <read_num>:
   10b7c:	fe010113          	addi	sp,sp,-32
   10b80:	00812e23          	sw	s0,28(sp)
   10b84:	02010413          	addi	s0,sp,32
   10b88:	00500893          	li	a7,5
   10b8c:	00000073          	ecall
   10b90:	00050713          	mv	a4,a0
   10b94:	fee42423          	sw	a4,-24(s0)
   10b98:	fef42623          	sw	a5,-20(s0)
   10b9c:	fe842703          	lw	a4,-24(s0)
   10ba0:	fec42783          	lw	a5,-20(s0)
   10ba4:	00070513          	mv	a0,a4
   10ba8:	00078593          	mv	a1,a5
   10bac:	01c12403          	lw	s0,28(sp)
   10bb0:	02010113          	addi	sp,sp,32
   10bb4:	00008067          	ret

00010bb8 <__mulsi3>:
   10bb8:	00050613          	mv	a2,a0
   10bbc:	00000513          	li	a0,0
   10bc0:	0015f693          	andi	a3,a1,1
   10bc4:	00068463          	beqz	a3,10bcc <__mulsi3+0x14>
   10bc8:	00c50533          	add	a0,a0,a2
   10bcc:	0015d593          	srli	a1,a1,0x1
   10bd0:	00161613          	slli	a2,a2,0x1
   10bd4:	fe0596e3          	bnez	a1,10bc0 <__mulsi3+0x8>
   10bd8:	00008067          	ret

00010bdc <__muldi3>:
   10bdc:	00050313          	mv	t1,a0
   10be0:	ff010113          	addi	sp,sp,-16
   10be4:	00060513          	mv	a0,a2
   10be8:	00068893          	mv	a7,a3
   10bec:	00112623          	sw	ra,12(sp)
   10bf0:	00030613          	mv	a2,t1
   10bf4:	00050693          	mv	a3,a0
   10bf8:	00000713          	li	a4,0
   10bfc:	00000793          	li	a5,0
   10c00:	00000813          	li	a6,0
   10c04:	0016fe13          	andi	t3,a3,1
   10c08:	00171e93          	slli	t4,a4,0x1
   10c0c:	000e0c63          	beqz	t3,10c24 <__muldi3+0x48>
   10c10:	01060e33          	add	t3,a2,a6
   10c14:	010e3833          	sltu	a6,t3,a6
   10c18:	00e787b3          	add	a5,a5,a4
   10c1c:	00f807b3          	add	a5,a6,a5
   10c20:	000e0813          	mv	a6,t3
   10c24:	01f65713          	srli	a4,a2,0x1f
   10c28:	0016d693          	srli	a3,a3,0x1
   10c2c:	00eee733          	or	a4,t4,a4
   10c30:	00161613          	slli	a2,a2,0x1
   10c34:	fc0698e3          	bnez	a3,10c04 <__muldi3+0x28>
   10c38:	00058663          	beqz	a1,10c44 <__muldi3+0x68>
   10c3c:	f7dff0ef          	jal	ra,10bb8 <__mulsi3>
   10c40:	00a787b3          	add	a5,a5,a0
   10c44:	00088a63          	beqz	a7,10c58 <__muldi3+0x7c>
   10c48:	00030513          	mv	a0,t1
   10c4c:	00088593          	mv	a1,a7
   10c50:	f69ff0ef          	jal	ra,10bb8 <__mulsi3>
   10c54:	00f507b3          	add	a5,a0,a5
   10c58:	00c12083          	lw	ra,12(sp)
   10c5c:	00080513          	mv	a0,a6
   10c60:	00078593          	mv	a1,a5
   10c64:	01010113          	addi	sp,sp,16
   10c68:	00008067          	ret

00010c6c <exit>:
   10c6c:	ff010113          	addi	sp,sp,-16
   10c70:	00000593          	li	a1,0
   10c74:	00812423          	sw	s0,8(sp)
   10c78:	00112623          	sw	ra,12(sp)
   10c7c:	00050413          	mv	s0,a0
   10c80:	194000ef          	jal	ra,10e14 <__call_exitprocs>
   10c84:	c2c1a503          	lw	a0,-980(gp) # 1251c <_global_impure_ptr>
   10c88:	03c52783          	lw	a5,60(a0)
   10c8c:	00078463          	beqz	a5,10c94 <exit+0x28>
   10c90:	000780e7          	jalr	a5
   10c94:	00040513          	mv	a0,s0
   10c98:	3a4000ef          	jal	ra,1103c <_exit>

00010c9c <__libc_init_array>:
   10c9c:	ff010113          	addi	sp,sp,-16
   10ca0:	00812423          	sw	s0,8(sp)
   10ca4:	01212023          	sw	s2,0(sp)
   10ca8:	00012437          	lui	s0,0x12
   10cac:	00012937          	lui	s2,0x12
   10cb0:	0e040793          	addi	a5,s0,224 # 120e0 <__init_array_start>
   10cb4:	0e090913          	addi	s2,s2,224 # 120e0 <__init_array_start>
   10cb8:	40f90933          	sub	s2,s2,a5
   10cbc:	00112623          	sw	ra,12(sp)
   10cc0:	00912223          	sw	s1,4(sp)
   10cc4:	40295913          	srai	s2,s2,0x2
   10cc8:	02090063          	beqz	s2,10ce8 <__libc_init_array+0x4c>
   10ccc:	0e040413          	addi	s0,s0,224
   10cd0:	00000493          	li	s1,0
   10cd4:	00042783          	lw	a5,0(s0)
   10cd8:	00148493          	addi	s1,s1,1
   10cdc:	00440413          	addi	s0,s0,4
   10ce0:	000780e7          	jalr	a5
   10ce4:	fe9918e3          	bne	s2,s1,10cd4 <__libc_init_array+0x38>
   10ce8:	00012437          	lui	s0,0x12
   10cec:	00012937          	lui	s2,0x12
   10cf0:	0e040793          	addi	a5,s0,224 # 120e0 <__init_array_start>
   10cf4:	0e890913          	addi	s2,s2,232 # 120e8 <__init_array_end>
   10cf8:	40f90933          	sub	s2,s2,a5
   10cfc:	40295913          	srai	s2,s2,0x2
   10d00:	02090063          	beqz	s2,10d20 <__libc_init_array+0x84>
   10d04:	0e040413          	addi	s0,s0,224
   10d08:	00000493          	li	s1,0
   10d0c:	00042783          	lw	a5,0(s0)
   10d10:	00148493          	addi	s1,s1,1
   10d14:	00440413          	addi	s0,s0,4
   10d18:	000780e7          	jalr	a5
   10d1c:	fe9918e3          	bne	s2,s1,10d0c <__libc_init_array+0x70>
   10d20:	00c12083          	lw	ra,12(sp)
   10d24:	00812403          	lw	s0,8(sp)
   10d28:	00412483          	lw	s1,4(sp)
   10d2c:	00012903          	lw	s2,0(sp)
   10d30:	01010113          	addi	sp,sp,16
   10d34:	00008067          	ret

00010d38 <memset>:
   10d38:	00f00313          	li	t1,15
   10d3c:	00050713          	mv	a4,a0
   10d40:	02c37e63          	bgeu	t1,a2,10d7c <memset+0x44>
   10d44:	00f77793          	andi	a5,a4,15
   10d48:	0a079063          	bnez	a5,10de8 <memset+0xb0>
   10d4c:	08059263          	bnez	a1,10dd0 <memset+0x98>
   10d50:	ff067693          	andi	a3,a2,-16
   10d54:	00f67613          	andi	a2,a2,15
   10d58:	00e686b3          	add	a3,a3,a4
   10d5c:	00b72023          	sw	a1,0(a4)
   10d60:	00b72223          	sw	a1,4(a4)
   10d64:	00b72423          	sw	a1,8(a4)
   10d68:	00b72623          	sw	a1,12(a4)
   10d6c:	01070713          	addi	a4,a4,16
   10d70:	fed766e3          	bltu	a4,a3,10d5c <memset+0x24>
   10d74:	00061463          	bnez	a2,10d7c <memset+0x44>
   10d78:	00008067          	ret
   10d7c:	40c306b3          	sub	a3,t1,a2
   10d80:	00269693          	slli	a3,a3,0x2
   10d84:	00000297          	auipc	t0,0x0
   10d88:	005686b3          	add	a3,a3,t0
   10d8c:	00c68067          	jr	12(a3)
   10d90:	00b70723          	sb	a1,14(a4)
   10d94:	00b706a3          	sb	a1,13(a4)
   10d98:	00b70623          	sb	a1,12(a4)
   10d9c:	00b705a3          	sb	a1,11(a4)
   10da0:	00b70523          	sb	a1,10(a4)
   10da4:	00b704a3          	sb	a1,9(a4)
   10da8:	00b70423          	sb	a1,8(a4)
   10dac:	00b703a3          	sb	a1,7(a4)
   10db0:	00b70323          	sb	a1,6(a4)
   10db4:	00b702a3          	sb	a1,5(a4)
   10db8:	00b70223          	sb	a1,4(a4)
   10dbc:	00b701a3          	sb	a1,3(a4)
   10dc0:	00b70123          	sb	a1,2(a4)
   10dc4:	00b700a3          	sb	a1,1(a4)
   10dc8:	00b70023          	sb	a1,0(a4)
   10dcc:	00008067          	ret
   10dd0:	0ff5f593          	andi	a1,a1,255
   10dd4:	00859693          	slli	a3,a1,0x8
   10dd8:	00d5e5b3          	or	a1,a1,a3
   10ddc:	01059693          	slli	a3,a1,0x10
   10de0:	00d5e5b3          	or	a1,a1,a3
   10de4:	f6dff06f          	j	10d50 <memset+0x18>
   10de8:	00279693          	slli	a3,a5,0x2
   10dec:	00000297          	auipc	t0,0x0
   10df0:	005686b3          	add	a3,a3,t0
   10df4:	00008293          	mv	t0,ra
   10df8:	fa0680e7          	jalr	-96(a3)
   10dfc:	00028093          	mv	ra,t0
   10e00:	ff078793          	addi	a5,a5,-16
   10e04:	40f70733          	sub	a4,a4,a5
   10e08:	00f60633          	add	a2,a2,a5
   10e0c:	f6c378e3          	bgeu	t1,a2,10d7c <memset+0x44>
   10e10:	f3dff06f          	j	10d4c <memset+0x14>

00010e14 <__call_exitprocs>:
   10e14:	fd010113          	addi	sp,sp,-48
   10e18:	01412c23          	sw	s4,24(sp)
   10e1c:	c2c1aa03          	lw	s4,-980(gp) # 1251c <_global_impure_ptr>
   10e20:	03212023          	sw	s2,32(sp)
   10e24:	02112623          	sw	ra,44(sp)
   10e28:	148a2903          	lw	s2,328(s4)
   10e2c:	02812423          	sw	s0,40(sp)
   10e30:	02912223          	sw	s1,36(sp)
   10e34:	01312e23          	sw	s3,28(sp)
   10e38:	01512a23          	sw	s5,20(sp)
   10e3c:	01612823          	sw	s6,16(sp)
   10e40:	01712623          	sw	s7,12(sp)
   10e44:	01812423          	sw	s8,8(sp)
   10e48:	04090063          	beqz	s2,10e88 <__call_exitprocs+0x74>
   10e4c:	00050b13          	mv	s6,a0
   10e50:	00058b93          	mv	s7,a1
   10e54:	00100a93          	li	s5,1
   10e58:	fff00993          	li	s3,-1
   10e5c:	00492483          	lw	s1,4(s2)
   10e60:	fff48413          	addi	s0,s1,-1
   10e64:	02044263          	bltz	s0,10e88 <__call_exitprocs+0x74>
   10e68:	00249493          	slli	s1,s1,0x2
   10e6c:	009904b3          	add	s1,s2,s1
   10e70:	040b8463          	beqz	s7,10eb8 <__call_exitprocs+0xa4>
   10e74:	1044a783          	lw	a5,260(s1)
   10e78:	05778063          	beq	a5,s7,10eb8 <__call_exitprocs+0xa4>
   10e7c:	fff40413          	addi	s0,s0,-1
   10e80:	ffc48493          	addi	s1,s1,-4
   10e84:	ff3416e3          	bne	s0,s3,10e70 <__call_exitprocs+0x5c>
   10e88:	02c12083          	lw	ra,44(sp)
   10e8c:	02812403          	lw	s0,40(sp)
   10e90:	02412483          	lw	s1,36(sp)
   10e94:	02012903          	lw	s2,32(sp)
   10e98:	01c12983          	lw	s3,28(sp)
   10e9c:	01812a03          	lw	s4,24(sp)
   10ea0:	01412a83          	lw	s5,20(sp)
   10ea4:	01012b03          	lw	s6,16(sp)
   10ea8:	00c12b83          	lw	s7,12(sp)
   10eac:	00812c03          	lw	s8,8(sp)
   10eb0:	03010113          	addi	sp,sp,48
   10eb4:	00008067          	ret
   10eb8:	00492783          	lw	a5,4(s2)
   10ebc:	0044a683          	lw	a3,4(s1)
   10ec0:	fff78793          	addi	a5,a5,-1
   10ec4:	04878e63          	beq	a5,s0,10f20 <__call_exitprocs+0x10c>
   10ec8:	0004a223          	sw	zero,4(s1)
   10ecc:	fa0688e3          	beqz	a3,10e7c <__call_exitprocs+0x68>
   10ed0:	18892783          	lw	a5,392(s2)
   10ed4:	008a9733          	sll	a4,s5,s0
   10ed8:	00492c03          	lw	s8,4(s2)
   10edc:	00f777b3          	and	a5,a4,a5
   10ee0:	02079263          	bnez	a5,10f04 <__call_exitprocs+0xf0>
   10ee4:	000680e7          	jalr	a3
   10ee8:	00492703          	lw	a4,4(s2)
   10eec:	148a2783          	lw	a5,328(s4)
   10ef0:	01871463          	bne	a4,s8,10ef8 <__call_exitprocs+0xe4>
   10ef4:	f8f904e3          	beq	s2,a5,10e7c <__call_exitprocs+0x68>
   10ef8:	f80788e3          	beqz	a5,10e88 <__call_exitprocs+0x74>
   10efc:	00078913          	mv	s2,a5
   10f00:	f5dff06f          	j	10e5c <__call_exitprocs+0x48>
   10f04:	18c92783          	lw	a5,396(s2)
   10f08:	0844a583          	lw	a1,132(s1)
   10f0c:	00f77733          	and	a4,a4,a5
   10f10:	00071c63          	bnez	a4,10f28 <__call_exitprocs+0x114>
   10f14:	000b0513          	mv	a0,s6
   10f18:	000680e7          	jalr	a3
   10f1c:	fcdff06f          	j	10ee8 <__call_exitprocs+0xd4>
   10f20:	00892223          	sw	s0,4(s2)
   10f24:	fa9ff06f          	j	10ecc <__call_exitprocs+0xb8>
   10f28:	00058513          	mv	a0,a1
   10f2c:	000680e7          	jalr	a3
   10f30:	fb9ff06f          	j	10ee8 <__call_exitprocs+0xd4>

00010f34 <__libc_fini_array>:
   10f34:	ff010113          	addi	sp,sp,-16
   10f38:	00812423          	sw	s0,8(sp)
   10f3c:	000127b7          	lui	a5,0x12
   10f40:	00012437          	lui	s0,0x12
   10f44:	0e840413          	addi	s0,s0,232 # 120e8 <__init_array_end>
   10f48:	0ec78793          	addi	a5,a5,236 # 120ec <__fini_array_end>
   10f4c:	408787b3          	sub	a5,a5,s0
   10f50:	00912223          	sw	s1,4(sp)
   10f54:	00112623          	sw	ra,12(sp)
   10f58:	4027d493          	srai	s1,a5,0x2
   10f5c:	02048063          	beqz	s1,10f7c <__libc_fini_array+0x48>
   10f60:	ffc78793          	addi	a5,a5,-4
   10f64:	00878433          	add	s0,a5,s0
   10f68:	00042783          	lw	a5,0(s0)
   10f6c:	fff48493          	addi	s1,s1,-1
   10f70:	ffc40413          	addi	s0,s0,-4
   10f74:	000780e7          	jalr	a5
   10f78:	fe0498e3          	bnez	s1,10f68 <__libc_fini_array+0x34>
   10f7c:	00c12083          	lw	ra,12(sp)
   10f80:	00812403          	lw	s0,8(sp)
   10f84:	00412483          	lw	s1,4(sp)
   10f88:	01010113          	addi	sp,sp,16
   10f8c:	00008067          	ret

00010f90 <atexit>:
   10f90:	00050593          	mv	a1,a0
   10f94:	00000693          	li	a3,0
   10f98:	00000613          	li	a2,0
   10f9c:	00000513          	li	a0,0
   10fa0:	0040006f          	j	10fa4 <__register_exitproc>

00010fa4 <__register_exitproc>:
   10fa4:	c2c1a703          	lw	a4,-980(gp) # 1251c <_global_impure_ptr>
   10fa8:	14872783          	lw	a5,328(a4)
   10fac:	04078c63          	beqz	a5,11004 <__register_exitproc+0x60>
   10fb0:	0047a703          	lw	a4,4(a5)
   10fb4:	01f00813          	li	a6,31
   10fb8:	06e84e63          	blt	a6,a4,11034 <__register_exitproc+0x90>
   10fbc:	00271813          	slli	a6,a4,0x2
   10fc0:	02050663          	beqz	a0,10fec <__register_exitproc+0x48>
   10fc4:	01078333          	add	t1,a5,a6
   10fc8:	08c32423          	sw	a2,136(t1) # 101cc <matmulti+0x7c>
   10fcc:	1887a883          	lw	a7,392(a5)
   10fd0:	00100613          	li	a2,1
   10fd4:	00e61633          	sll	a2,a2,a4
   10fd8:	00c8e8b3          	or	a7,a7,a2
   10fdc:	1917a423          	sw	a7,392(a5)
   10fe0:	10d32423          	sw	a3,264(t1)
   10fe4:	00200693          	li	a3,2
   10fe8:	02d50463          	beq	a0,a3,11010 <__register_exitproc+0x6c>
   10fec:	00170713          	addi	a4,a4,1
   10ff0:	00e7a223          	sw	a4,4(a5)
   10ff4:	010787b3          	add	a5,a5,a6
   10ff8:	00b7a423          	sw	a1,8(a5)
   10ffc:	00000513          	li	a0,0
   11000:	00008067          	ret
   11004:	14c70793          	addi	a5,a4,332
   11008:	14f72423          	sw	a5,328(a4)
   1100c:	fa5ff06f          	j	10fb0 <__register_exitproc+0xc>
   11010:	18c7a683          	lw	a3,396(a5)
   11014:	00170713          	addi	a4,a4,1
   11018:	00e7a223          	sw	a4,4(a5)
   1101c:	00c6e633          	or	a2,a3,a2
   11020:	18c7a623          	sw	a2,396(a5)
   11024:	010787b3          	add	a5,a5,a6
   11028:	00b7a423          	sw	a1,8(a5)
   1102c:	00000513          	li	a0,0
   11030:	00008067          	ret
   11034:	fff00513          	li	a0,-1
   11038:	00008067          	ret

0001103c <_exit>:
   1103c:	00000593          	li	a1,0
   11040:	00000613          	li	a2,0
   11044:	00000693          	li	a3,0
   11048:	00000713          	li	a4,0
   1104c:	00000793          	li	a5,0
   11050:	05d00893          	li	a7,93
   11054:	00000073          	ecall
   11058:	00054463          	bltz	a0,11060 <_exit+0x24>
   1105c:	0000006f          	j	1105c <_exit+0x20>
   11060:	ff010113          	addi	sp,sp,-16
   11064:	00812423          	sw	s0,8(sp)
   11068:	00050413          	mv	s0,a0
   1106c:	00112623          	sw	ra,12(sp)
   11070:	40800433          	neg	s0,s0
   11074:	00c000ef          	jal	ra,11080 <__errno>
   11078:	00852023          	sw	s0,0(a0)
   1107c:	0000006f          	j	1107c <_exit+0x40>

00011080 <__errno>:
   11080:	c341a503          	lw	a0,-972(gp) # 12524 <_impure_ptr>
   11084:	00008067          	ret

Disassembly of section .rodata:

00011088 <.rodata>:
   11088:	6854                	flw	fa3,20(s0)
   1108a:	2065                	jal	11132 <__errno+0xb2>
   1108c:	746e6f63          	bltu	t3,t1,117ea <__errno+0x76a>
   11090:	6e65                	lui	t3,0x19
   11092:	2074                	fld	fa3,192(s0)
   11094:	4120666f          	jal	a2,174a6 <__global_pointer$+0x4bb6>
   11098:	6920                	flw	fs0,80(a0)
   1109a:	0a203a73          	csrrc	s4,0xa2,zero
   1109e:	0000                	unimp
   110a0:	0020                	addi	s0,sp,8
   110a2:	0000                	unimp
   110a4:	000a                	c.slli	zero,0x2
   110a6:	0000                	unimp
   110a8:	6854                	flw	fa3,20(s0)
   110aa:	2065                	jal	11152 <__errno+0xd2>
   110ac:	746e6f63          	bltu	t3,t1,1180a <__errno+0x78a>
   110b0:	6e65                	lui	t3,0x19
   110b2:	2074                	fld	fa3,192(s0)
   110b4:	4220666f          	jal	a2,174d6 <__global_pointer$+0x4be6>
   110b8:	6920                	flw	fs0,80(a0)
   110ba:	0a203a73          	csrrc	s4,0xa2,zero
   110be:	0000                	unimp
   110c0:	6854                	flw	fa3,20(s0)
   110c2:	2065                	jal	1116a <__errno+0xea>
   110c4:	746e6f63          	bltu	t3,t1,11822 <__errno+0x7a2>
   110c8:	6e65                	lui	t3,0x19
   110ca:	2074                	fld	fa3,192(s0)
   110cc:	4320666f          	jal	a2,174fe <__global_pointer$+0x4c0e>
   110d0:	413d                	li	sp,15
   110d2:	422a                	lw	tp,136(sp)
   110d4:	6920                	flw	fs0,80(a0)
   110d6:	0a203a73          	csrrc	s4,0xa2,zero
	...

Disassembly of section .eh_frame:

000120dc <__FRAME_END__>:
   120dc:	0000                	unimp
	...

Disassembly of section .init_array:

000120e0 <__init_array_start>:
   120e0:	0074                	addi	a3,sp,12
   120e2:	0001                	nop

000120e4 <__frame_dummy_init_array_entry>:
   120e4:	012c                	addi	a1,sp,136
   120e6:	0001                	nop

Disassembly of section .fini_array:

000120e8 <__do_global_dtors_aux_fini_array_entry>:
   120e8:	00dc                	addi	a5,sp,68
   120ea:	0001                	nop

Disassembly of section .data:

000120f0 <__DATA_BEGIN__>:
   120f0:	0000                	unimp
   120f2:	0000                	unimp
   120f4:	23dc                	fld	fa5,128(a5)
   120f6:	0001                	nop
   120f8:	2444                	fld	fs1,136(s0)
   120fa:	0001                	nop
   120fc:	24ac                	fld	fa1,72(s1)
   120fe:	0001                	nop
	...
   12198:	0001                	nop
   1219a:	0000                	unimp
   1219c:	0000                	unimp
   1219e:	0000                	unimp
   121a0:	330e                	fld	ft6,224(sp)
   121a2:	abcd                	j	12794 <__BSS_END__+0x250>
   121a4:	1234                	addi	a3,sp,296
   121a6:	e66d                	bnez	a2,12290 <__DATA_BEGIN__+0x1a0>
   121a8:	deec                	sw	a1,124(a3)
   121aa:	0005                	c.nop	1
   121ac:	0000000b          	0xb
	...

Disassembly of section .sdata:

00012518 <M>:
   12518:	000a                	c.slli	zero,0x2
	...

0001251c <_global_impure_ptr>:
   1251c:	20f0                	fld	fa2,192(s1)
   1251e:	0001                	nop

00012520 <__dso_handle>:
   12520:	0000                	unimp
	...

00012524 <_impure_ptr>:
   12524:	20f0                	fld	fa2,192(s1)
   12526:	0001                	nop

Disassembly of section .bss:

00012528 <__bss_start>:
   12528:	0000                	unimp
	...

0001252c <object.5495>:
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
  10:	0bb8                	addi	a4,sp,472
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
  30:	0bdc                	addi	a5,sp,468
  32:	0001                	nop
  34:	0090                	addi	a2,sp,64
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
  10:	0bb8                	addi	a4,sp,472
  12:	0001                	nop
  14:	0bdc                	addi	a5,sp,468
  16:	0001                	nop
  18:	0000                	unimp
  1a:	0000                	unimp
  1c:	00000033          	add	zero,zero,zero
  20:	0091                	addi	ra,ra,4
  22:	0000                	unimp
  24:	8001                	c.srli64	s0
  26:	0d11                	addi	s10,s10,4
  28:	0000                	unimp
  2a:	0004                	0x4
  2c:	0014                	0x14
  2e:	0000                	unimp
  30:	0104                	addi	s1,sp,128
  32:	0581                	addi	a1,a1,0
  34:	0000                	unimp
  36:	280c                	fld	fa1,16(s0)
  38:	33000003          	lb	zero,816(zero) # 330 <register_fini-0xfd44>
  3c:	0000                	unimp
  3e:	dc00                	sw	s0,56(s0)
  40:	9000010b          	0x9000010b
  44:	0000                	unimp
  46:	9300                	0x9300
  48:	0000                	unimp
  4a:	0200                	addi	s0,sp,256
  4c:	0708                	addi	a0,sp,896
  4e:	0000013b          	0x13b
  52:	69050403          	lb	s0,1680(a0)
  56:	746e                	flw	fs0,248(sp)
  58:	0200                	addi	s0,sp,256
  5a:	0704                	addi	s1,sp,896
  5c:	0145                	addi	sp,sp,17
  5e:	0000                	unimp
  60:	0802                	c.slli64	a6
  62:	7005                	c.lui	zero,0xfffe1
  64:	0004                	0x4
  66:	0200                	addi	s0,sp,256
  68:	0410                	addi	a2,sp,512
  6a:	0170                	addi	a2,sp,140
  6c:	0000                	unimp
  6e:	0102                	c.slli64	sp
  70:	e306                	fsw	ft1,132(sp)
  72:	0006                	c.slli	zero,0x1
  74:	0200                	addi	s0,sp,256
  76:	0801                	addi	a6,a6,0
  78:	06e1                	addi	a3,a3,24
  7a:	0000                	unimp
  7c:	0202                	c.slli64	tp
  7e:	9d05                	0x9d05
  80:	0000                	unimp
  82:	0200                	addi	s0,sp,256
  84:	0702                	c.slli64	a4
  86:	0000035b          	0x35b
  8a:	0402                	c.slli64	s0
  8c:	7505                	lui	a0,0xfffe1
  8e:	0004                	0x4
  90:	0200                	addi	s0,sp,256
  92:	0704                	addi	s1,sp,896
  94:	0140                	addi	s0,sp,132
  96:	0000                	unimp
  98:	c504                	sw	s1,8(a0)
  9a:	02000003          	lb	zero,32(zero) # 20 <register_fini-0x10054>
  9e:	015e                	slli	sp,sp,0x17
  a0:	00003317          	auipc	t1,0x3
  a4:	0500                	addi	s0,sp,640
  a6:	04a4                	addi	s1,sp,584
  a8:	0000                	unimp
  aa:	640e2e03          	lw	t3,1600(t3) # 19640 <__global_pointer$+0x6d50>
  ae:	0000                	unimp
  b0:	0500                	addi	s0,sp,640
  b2:	0685                	addi	a3,a3,1
  b4:	0000                	unimp
  b6:	640e7403          	0x640e7403
  ba:	0000                	unimp
  bc:	0500                	addi	s0,sp,640
  be:	073e                	slli	a4,a4,0xf
  c0:	0000                	unimp
  c2:	2c179303          	lh	t1,705(a5)
  c6:	0000                	unimp
  c8:	0600                	addi	s0,sp,768
  ca:	0304                	addi	s1,sp,384
  cc:	03a5                	addi	t2,t2,9
  ce:	00c5                	addi	ra,ra,17
  d0:	0000                	unimp
  d2:	0001e907          	0x1e907
  d6:	0300                	addi	s0,sp,384
  d8:	00720ca7          	0x720ca7
  dc:	0000                	unimp
  de:	0002f707          	0x2f707
  e2:	0300                	addi	s0,sp,384
  e4:	13a8                	addi	a0,sp,488
  e6:	00c5                	addi	ra,ra,17
  e8:	0000                	unimp
  ea:	0800                	addi	s0,sp,16
  ec:	0000004f          	fnmadd.s	ft0,ft0,ft0,ft0,rne
  f0:	00d5                	addi	ra,ra,21
  f2:	0000                	unimp
  f4:	3309                	jal	fffffdf6 <__global_pointer$+0xfffed506>
  f6:	0000                	unimp
  f8:	0300                	addi	s0,sp,384
  fa:	0a00                	addi	s0,sp,272
  fc:	0308                	addi	a0,sp,384
  fe:	09a2                	slli	s3,s3,0x8
 100:	00f9                	addi	ra,ra,30
 102:	0000                	unimp
 104:	00066f0b          	0x66f0b
 108:	0300                	addi	s0,sp,384
 10a:	07a4                	addi	s1,sp,968
 10c:	002c                	addi	a1,sp,8
 10e:	0000                	unimp
 110:	0b00                	addi	s0,sp,400
 112:	00000677          	0x677
 116:	a305a903          	lw	s2,-1488(a1)
 11a:	0000                	unimp
 11c:	0400                	addi	s0,sp,512
 11e:	0500                	addi	s0,sp,640
 120:	04c8                	addi	a0,sp,580
 122:	0000                	unimp
 124:	d503aa03          	lw	s4,-688(t2)
 128:	0000                	unimp
 12a:	0c00                	addi	s0,sp,528
 12c:	0504                	addi	s1,sp,640
 12e:	06f4                	addi	a3,sp,844
 130:	0000                	unimp
 132:	1604                	addi	s1,sp,800
 134:	6b19                	lui	s6,0x6
 136:	0000                	unimp
 138:	0500                	addi	s0,sp,640
 13a:	000004d3          	fadd.s	fs1,ft0,ft0,rne
 13e:	0c05                	addi	s8,s8,1
 140:	2c0d                	jal	372 <register_fini-0xfd02>
 142:	0000                	unimp
 144:	0500                	addi	s0,sp,640
 146:	0528                	addi	a0,sp,648
 148:	0000                	unimp
 14a:	2304                	fld	fs1,0(a4)
 14c:	0001131b          	0x1131b
 150:	0d00                	addi	s0,sp,656
 152:	02ba                	slli	t0,t0,0xe
 154:	0000                	unimp
 156:	0418                	addi	a4,sp,512
 158:	0834                	addi	a3,sp,24
 15a:	0185                	addi	gp,gp,1
 15c:	0000                	unimp
 15e:	0005710b          	0x5710b
 162:	0400                	addi	s0,sp,512
 164:	1336                	slli	t1,t1,0x2d
 166:	0185                	addi	gp,gp,1
 168:	0000                	unimp
 16a:	0e00                	addi	s0,sp,784
 16c:	6b5f 0400 0737      	0x73704006b5f
 172:	002c                	addi	a1,sp,8
 174:	0000                	unimp
 176:	0b04                	addi	s1,sp,400
 178:	065a                	slli	a2,a2,0x16
 17a:	0000                	unimp
 17c:	3704                	fld	fs1,40(a4)
 17e:	00002c0b          	0x2c0b
 182:	0800                	addi	s0,sp,16
 184:	0002ac0b          	0x2ac0b
 188:	0400                	addi	s0,sp,512
 18a:	002c1437          	lui	s0,0x2c1
 18e:	0000                	unimp
 190:	0b0c                	addi	a1,sp,400
 192:	0221                	addi	tp,tp,8
 194:	0000                	unimp
 196:	3704                	fld	fs1,40(a4)
 198:	00002c1b          	0x2c1b
 19c:	1000                	addi	s0,sp,32
 19e:	5f0e                	lw	t5,224(sp)
 1a0:	0078                	addi	a4,sp,12
 1a2:	3804                	fld	fs1,48(s0)
 1a4:	00018b0b          	0x18b0b
 1a8:	1400                	addi	s0,sp,544
 1aa:	0f00                	addi	s0,sp,912
 1ac:	2b04                	fld	fs1,16(a4)
 1ae:	0001                	nop
 1b0:	0800                	addi	s0,sp,16
 1b2:	00000107          	0x107
 1b6:	0000019b          	0x19b
 1ba:	3309                	jal	fffffebc <__global_pointer$+0xfffed5cc>
 1bc:	0000                	unimp
 1be:	0000                	unimp
 1c0:	0d00                	addi	s0,sp,656
 1c2:	02da                	slli	t0,t0,0x16
 1c4:	0000                	unimp
 1c6:	0424                	addi	s1,sp,520
 1c8:	083c                	addi	a5,sp,24
 1ca:	021e                	slli	tp,tp,0x7
 1cc:	0000                	unimp
 1ce:	0001b20b          	0x1b20b
 1d2:	0400                	addi	s0,sp,512
 1d4:	093e                	slli	s2,s2,0xf
 1d6:	002c                	addi	a1,sp,8
 1d8:	0000                	unimp
 1da:	0b00                	addi	s0,sp,400
 1dc:	0792                	slli	a5,a5,0x4
 1de:	0000                	unimp
 1e0:	3f04                	fld	fs1,56(a4)
 1e2:	2c09                	jal	3f4 <register_fini-0xfc80>
 1e4:	0000                	unimp
 1e6:	0400                	addi	s0,sp,512
 1e8:	0001df0b          	0x1df0b
 1ec:	0400                	addi	s0,sp,512
 1ee:	0940                	addi	s0,sp,148
 1f0:	002c                	addi	a1,sp,8
 1f2:	0000                	unimp
 1f4:	0b08                	addi	a0,sp,400
 1f6:	07e8                	addi	a0,sp,972
 1f8:	0000                	unimp
 1fa:	4104                	lw	s1,0(a0)
 1fc:	2c09                	jal	40e <register_fini-0xfc66>
 1fe:	0000                	unimp
 200:	0c00                	addi	s0,sp,528
 202:	00047e0b          	0x47e0b
 206:	0400                	addi	s0,sp,512
 208:	0942                	slli	s2,s2,0x10
 20a:	002c                	addi	a1,sp,8
 20c:	0000                	unimp
 20e:	0b10                	addi	a2,sp,400
 210:	0420                	addi	s0,sp,520
 212:	0000                	unimp
 214:	4304                	lw	s1,0(a4)
 216:	2c09                	jal	428 <register_fini-0xfc4c>
 218:	0000                	unimp
 21a:	1400                	addi	s0,sp,544
 21c:	0007270b          	0x7270b
 220:	0400                	addi	s0,sp,512
 222:	0944                	addi	s1,sp,148
 224:	002c                	addi	a1,sp,8
 226:	0000                	unimp
 228:	0b18                	addi	a4,sp,400
 22a:	07ce                	slli	a5,a5,0x13
 22c:	0000                	unimp
 22e:	4504                	lw	s1,8(a0)
 230:	2c09                	jal	442 <register_fini-0xfc32>
 232:	0000                	unimp
 234:	1c00                	addi	s0,sp,560
 236:	0007780b          	0x7780b
 23a:	0400                	addi	s0,sp,512
 23c:	0946                	slli	s2,s2,0x11
 23e:	002c                	addi	a1,sp,8
 240:	0000                	unimp
 242:	0020                	addi	s0,sp,8
 244:	f410                	fsw	fa2,40(s0)
 246:	0001                	nop
 248:	0800                	addi	s0,sp,16
 24a:	0401                	addi	s0,s0,0
 24c:	0263084f          	fnmadd.d	fa6,ft6,ft6,ft0,rne
 250:	0000                	unimp
 252:	0002980b          	0x2980b
 256:	0400                	addi	s0,sp,512
 258:	0a50                	addi	a2,sp,276
 25a:	00000263          	beqz	zero,25e <register_fini-0xfe16>
 25e:	0b00                	addi	s0,sp,400
 260:	0504                	addi	s1,sp,640
 262:	0000                	unimp
 264:	5104                	lw	s1,32(a0)
 266:	6309                	lui	t1,0x2
 268:	0002                	c.slli64	zero
 26a:	8000                	0x8000
 26c:	d811                	beqz	s0,180 <register_fini-0xfef4>
 26e:	0006                	c.slli	zero,0x1
 270:	0400                	addi	s0,sp,512
 272:	01070a53          	fadd.s	fs4,fa4,fa6,rne
 276:	0000                	unimp
 278:	0100                	addi	s0,sp,128
 27a:	1911                	addi	s2,s2,-28
 27c:	0002                	c.slli64	zero
 27e:	0400                	addi	s0,sp,512
 280:	0a56                	slli	s4,s4,0x15
 282:	00000107          	0x107
 286:	0104                	addi	s1,sp,128
 288:	0800                	addi	s0,sp,16
 28a:	0105                	addi	sp,sp,1
 28c:	0000                	unimp
 28e:	00000273          	0x273
 292:	3309                	jal	ffffff94 <__global_pointer$+0xfffed6a4>
 294:	0000                	unimp
 296:	1f00                	addi	s0,sp,944
 298:	1000                	addi	s0,sp,32
 29a:	00000487          	0x487
 29e:	0190                	addi	a2,sp,192
 2a0:	6204                	flw	fs1,0(a2)
 2a2:	b608                	fsd	fa0,40(a2)
 2a4:	0002                	c.slli64	zero
 2a6:	0b00                	addi	s0,sp,400
 2a8:	0571                	addi	a0,a0,28
 2aa:	0000                	unimp
 2ac:	6304                	flw	fs1,0(a4)
 2ae:	b612                	fsd	ft4,296(sp)
 2b0:	0002                	c.slli64	zero
 2b2:	0000                	unimp
 2b4:	0006320b          	0x6320b
 2b8:	0400                	addi	s0,sp,512
 2ba:	0664                	addi	s1,sp,780
 2bc:	002c                	addi	a1,sp,8
 2be:	0000                	unimp
 2c0:	0b04                	addi	s1,sp,400
 2c2:	000002a7          	0x2a7
 2c6:	6604                	flw	fs1,8(a2)
 2c8:	bc09                	j	fffffcda <__global_pointer$+0xfffed3ea>
 2ca:	0002                	c.slli64	zero
 2cc:	0800                	addi	s0,sp,16
 2ce:	0001f40b          	0x1f40b
 2d2:	0400                	addi	s0,sp,512
 2d4:	021e1e67          	0x21e1e67
 2d8:	0000                	unimp
 2da:	0088                	addi	a0,sp,64
 2dc:	0273040f          	0x273040f
 2e0:	0000                	unimp
 2e2:	cc08                	sw	a0,24(s0)
 2e4:	0002                	c.slli64	zero
 2e6:	cc00                	sw	s0,24(s0)
 2e8:	0002                	c.slli64	zero
 2ea:	0900                	addi	s0,sp,144
 2ec:	00000033          	add	zero,zero,zero
 2f0:	001f 040f 02d2      	0x2d2040f001f
 2f6:	0000                	unimp
 2f8:	0d12                	slli	s10,s10,0x4
 2fa:	0531                	addi	a0,a0,12
 2fc:	0000                	unimp
 2fe:	0408                	addi	a0,sp,512
 300:	087a                	slli	a6,a6,0x1e
 302:	000002fb          	0x2fb
 306:	0001d90b          	0x1d90b
 30a:	0400                	addi	s0,sp,512
 30c:	02fb117b          	0x2fb117b
 310:	0000                	unimp
 312:	0b00                	addi	s0,sp,400
 314:	00b9                	addi	ra,ra,14
 316:	0000                	unimp
 318:	7c04                	flw	fs1,56(s0)
 31a:	2c06                	fld	fs8,64(sp)
 31c:	0000                	unimp
 31e:	0400                	addi	s0,sp,512
 320:	0f00                	addi	s0,sp,912
 322:	4f04                	lw	s1,24(a4)
 324:	0000                	unimp
 326:	0d00                	addi	s0,sp,656
 328:	055a                	slli	a0,a0,0x16
 32a:	0000                	unimp
 32c:	0468                	addi	a0,sp,524
 32e:	08ba                	slli	a7,a7,0xe
 330:	0444                	addi	s1,sp,516
 332:	0000                	unimp
 334:	5f0e                	lw	t5,224(sp)
 336:	0070                	addi	a2,sp,12
 338:	bb04                	fsd	fs1,48(a4)
 33a:	fb12                	fsw	ft4,180(sp)
 33c:	0002                	c.slli64	zero
 33e:	0000                	unimp
 340:	5f0e                	lw	t5,224(sp)
 342:	0072                	c.slli	zero,0x1c
 344:	bc04                	fsd	fs1,56(s0)
 346:	00002c07          	flw	fs8,0(zero) # 0 <register_fini-0x10074>
 34a:	0400                	addi	s0,sp,512
 34c:	5f0e                	lw	t5,224(sp)
 34e:	bd040077          	0xbd040077
 352:	00002c07          	flw	fs8,0(zero) # 0 <register_fini-0x10074>
 356:	0800                	addi	s0,sp,16
 358:	0002120b          	0x2120b
 35c:	0400                	addi	s0,sp,512
 35e:	09be                	slli	s3,s3,0xf
 360:	0056                	c.slli	zero,0x15
 362:	0000                	unimp
 364:	0b0c                	addi	a1,sp,400
 366:	0306                	slli	t1,t1,0x1
 368:	0000                	unimp
 36a:	bf04                	fsd	fs1,56(a4)
 36c:	5609                	li	a2,-30
 36e:	0000                	unimp
 370:	0e00                	addi	s0,sp,784
 372:	5f0e                	lw	t5,224(sp)
 374:	6662                	flw	fa2,24(sp)
 376:	0400                	addi	s0,sp,512
 378:	11c0                	addi	s0,sp,228
 37a:	000002d3          	fadd.s	ft5,ft0,ft0,rne
 37e:	0b10                	addi	a2,sp,400
 380:	015f 0000 c104      	0xc1040000015f
 386:	00002c07          	flw	fs8,0(zero) # 0 <register_fini-0x10074>
 38a:	1800                	addi	s0,sp,48
 38c:	0002020b          	0x2020b
 390:	0400                	addi	s0,sp,512
 392:	0ac8                	addi	a0,sp,340
 394:	0105                	addi	sp,sp,1
 396:	0000                	unimp
 398:	0b1c                	addi	a5,sp,400
 39a:	04e5                	addi	s1,s1,25
 39c:	0000                	unimp
 39e:	ca04                	sw	s1,16(a2)
 3a0:	c81d                	beqz	s0,3d6 <register_fini-0xfc9e>
 3a2:	0005                	c.nop	1
 3a4:	2000                	fld	fs0,0(s0)
 3a6:	0004190b          	0x4190b
 3aa:	0400                	addi	s0,sp,512
 3ac:	1dcc                	addi	a1,sp,756
 3ae:	000005f7          	0x5f7
 3b2:	0b24                	addi	s1,sp,408
 3b4:	067f                	0x67f
 3b6:	0000                	unimp
 3b8:	cf04                	sw	s1,24(a4)
 3ba:	1b0d                	addi	s6,s6,-29
 3bc:	0006                	c.slli	zero,0x1
 3be:	2800                	fld	fs0,16(s0)
 3c0:	0001bb0b          	0x1bb0b
 3c4:	0400                	addi	s0,sp,512
 3c6:	09d0                	addi	a2,sp,212
 3c8:	0635                	addi	a2,a2,13
 3ca:	0000                	unimp
 3cc:	0e2c                	addi	a1,sp,792
 3ce:	755f 0062 d304      	0xd3040062755f
 3d4:	d311                	beqz	a4,2d8 <register_fini-0xfd9c>
 3d6:	0002                	c.slli64	zero
 3d8:	3000                	fld	fs0,32(s0)
 3da:	5f0e                	lw	t5,224(sp)
 3dc:	7075                	c.lui	zero,0xffffd
 3de:	0400                	addi	s0,sp,512
 3e0:	12d4                	addi	a3,sp,356
 3e2:	000002fb          	0x2fb
 3e6:	0e38                	addi	a4,sp,792
 3e8:	755f 0072 d504      	0xd5040072755f
 3ee:	00002c07          	flw	fs8,0(zero) # 0 <register_fini-0x10074>
 3f2:	3c00                	fld	fs0,56(s0)
 3f4:	0001c80b          	0x1c80b
 3f8:	0400                	addi	s0,sp,512
 3fa:	11d8                	addi	a4,sp,228
 3fc:	0000063b          	0x63b
 400:	0b40                	addi	s0,sp,404
 402:	076a                	slli	a4,a4,0x1a
 404:	0000                	unimp
 406:	d904                	sw	s1,48(a0)
 408:	4b11                	li	s6,4
 40a:	0006                	c.slli	zero,0x1
 40c:	4300                	lw	s0,0(a4)
 40e:	5f0e                	lw	t5,224(sp)
 410:	626c                	flw	fa1,68(a2)
 412:	0400                	addi	s0,sp,512
 414:	11dc                	addi	a5,sp,228
 416:	000002d3          	fadd.s	ft5,ft0,ft0,rne
 41a:	0b44                	addi	s1,sp,404
 41c:	0696                	slli	a3,a3,0x5
 41e:	0000                	unimp
 420:	df04                	sw	s1,56(a4)
 422:	00002c07          	flw	fs8,0(zero) # 0 <register_fini-0x10074>
 426:	4c00                	lw	s0,24(s0)
 428:	0004530b          	0x4530b
 42c:	0400                	addi	s0,sp,512
 42e:	0ae0                	addi	s0,sp,348
 430:	007f                	0x7f
 432:	0000                	unimp
 434:	0b50                	addi	a2,sp,404
 436:	00f8                	addi	a4,sp,76
 438:	0000                	unimp
 43a:	e304                	fsw	fs1,0(a4)
 43c:	6212                	flw	ft4,4(sp)
 43e:	0004                	0x4
 440:	5400                	lw	s0,40(s0)
 442:	0003cc0b          	0x3cc0b
 446:	0400                	addi	s0,sp,512
 448:	011f0ce7          	jalr	s9,17(t5)
 44c:	0000                	unimp
 44e:	0b58                	addi	a4,sp,404
 450:	02ee                	slli	t0,t0,0x1b
 452:	0000                	unimp
 454:	e904                	fsw	fs1,16(a0)
 456:	f90e                	fsw	ft3,176(sp)
 458:	0000                	unimp
 45a:	5c00                	lw	s0,56(s0)
 45c:	0005380b          	0x5380b
 460:	0400                	addi	s0,sp,512
 462:	09ea                	slli	s3,s3,0x1a
 464:	002c                	addi	a1,sp,8
 466:	0000                	unimp
 468:	0064                	addi	s1,sp,12
 46a:	00009713          	slli	a4,ra,0x0
 46e:	6200                	flw	fs0,0(a2)
 470:	0004                	0x4
 472:	1400                	addi	s0,sp,544
 474:	0462                	slli	s0,s0,0x18
 476:	0000                	unimp
 478:	0514                	addi	a3,sp,640
 47a:	0001                	nop
 47c:	1400                	addi	s0,sp,544
 47e:	05b6                	slli	a1,a1,0xd
 480:	0000                	unimp
 482:	2c14                	fld	fa3,24(s0)
 484:	0000                	unimp
 486:	0000                	unimp
 488:	046d040f          	0x46d040f
 48c:	0000                	unimp
 48e:	6215                	lui	tp,0x5
 490:	0004                	0x4
 492:	1600                	addi	s0,sp,800
 494:	0662                	slli	a2,a2,0x18
 496:	0000                	unimp
 498:	0428                	addi	a0,sp,520
 49a:	6504                	flw	fs1,8(a0)
 49c:	0802                	c.slli64	a6
 49e:	05b6                	slli	a1,a1,0xd
 4a0:	0000                	unimp
 4a2:	00052117          	auipc	sp,0x52
 4a6:	0400                	addi	s0,sp,512
 4a8:	2c070267          	jalr	tp,704(a4)
 4ac:	0000                	unimp
 4ae:	0000                	unimp
 4b0:	00073717          	auipc	a4,0x73
 4b4:	0400                	addi	s0,sp,512
 4b6:	026c                	addi	a1,sp,268
 4b8:	0006a70b          	0x6a70b
 4bc:	0400                	addi	s0,sp,512
 4be:	00071f17          	auipc	t5,0x71
 4c2:	0400                	addi	s0,sp,512
 4c4:	026c                	addi	a1,sp,268
 4c6:	a714                	fsd	fa3,8(a4)
 4c8:	0006                	c.slli	zero,0x1
 4ca:	0800                	addi	s0,sp,16
 4cc:	0002b217          	auipc	tp,0x2b
 4d0:	0400                	addi	s0,sp,512
 4d2:	026c                	addi	a1,sp,268
 4d4:	a71e                	fsd	ft7,392(sp)
 4d6:	0006                	c.slli	zero,0x1
 4d8:	0c00                	addi	s0,sp,528
 4da:	00062d17          	auipc	s10,0x62
 4de:	0400                	addi	s0,sp,512
 4e0:	026e                	slli	tp,tp,0x1b
 4e2:	2c08                	fld	fa0,24(s0)
 4e4:	0000                	unimp
 4e6:	1000                	addi	s0,sp,32
 4e8:	0000c717          	auipc	a4,0xc
 4ec:	0400                	addi	s0,sp,512
 4ee:	a708026f          	jal	tp,fff8075e <__global_pointer$+0xfff6de6e>
 4f2:	0008                	0x8
 4f4:	1400                	addi	s0,sp,544
 4f6:	00064117          	auipc	sp,0x64
 4fa:	0400                	addi	s0,sp,512
 4fc:	0272                	slli	tp,tp,0x1c
 4fe:	00002c07          	flw	fs8,0(zero) # 0 <register_fini-0x10074>
 502:	3000                	fld	fs0,32(s0)
 504:	0007d817          	auipc	a6,0x7d
 508:	0400                	addi	s0,sp,512
 50a:	bc160273          	0xbc160273
 50e:	0008                	0x8
 510:	3400                	fld	fs0,40(s0)
 512:	00049917          	auipc	s2,0x49
 516:	0400                	addi	s0,sp,512
 518:	0275                	addi	tp,tp,29
 51a:	00002c07          	flw	fs8,0(zero) # 0 <register_fini-0x10074>
 51e:	3800                	fld	fs0,48(s0)
 520:	00063717          	auipc	a4,0x63
 524:	0400                	addi	s0,sp,512
 526:	cd0a0277          	0xcd0a0277
 52a:	0008                	0x8
 52c:	3c00                	fld	fs0,56(s0)
 52e:	00039a17          	auipc	s4,0x39
 532:	0400                	addi	s0,sp,512
 534:	027a                	slli	tp,tp,0x1e
 536:	00018513          	mv	a0,gp
 53a:	4000                	lw	s0,0(s0)
 53c:	00022d17          	auipc	s10,0x22
 540:	0400                	addi	s0,sp,512
 542:	2c07027b          	0x2c07027b
 546:	0000                	unimp
 548:	4400                	lw	s0,8(s0)
 54a:	0007c917          	auipc	s2,0x7c
 54e:	0400                	addi	s0,sp,512
 550:	027c                	addi	a5,sp,268
 552:	00018513          	mv	a0,gp
 556:	4800                	lw	s0,16(s0)
 558:	0004b417          	auipc	s0,0x4b
 55c:	0400                	addi	s0,sp,512
 55e:	027d                	addi	tp,tp,31
 560:	d314                	sw	a3,32(a4)
 562:	0008                	0x8
 564:	4c00                	lw	s0,24(s0)
 566:	0002fe17          	auipc	t3,0x2f
 56a:	0400                	addi	s0,sp,512
 56c:	0280                	addi	s0,sp,320
 56e:	00002c07          	flw	fs8,0(zero) # 0 <register_fini-0x10074>
 572:	5000                	lw	s0,32(s0)
 574:	00026417          	auipc	s0,0x26
 578:	0400                	addi	s0,sp,512
 57a:	0281                	addi	t0,t0,0
 57c:	b609                	j	7e <register_fini-0xfff6>
 57e:	0005                	c.nop	1
 580:	5400                	lw	s0,40(s0)
 582:	00051a17          	auipc	s4,0x51
 586:	0400                	addi	s0,sp,512
 588:	02a4                	addi	s1,sp,328
 58a:	00088207          	0x88207
 58e:	5800                	lw	s0,48(s0)
 590:	8718                	0x8718
 592:	0004                	0x4
 594:	0400                	addi	s0,sp,512
 596:	02a8                	addi	a0,sp,328
 598:	0002b613          	sltiu	a2,t0,0
 59c:	4800                	lw	s0,16(s0)
 59e:	1801                	addi	a6,a6,-32
 5a0:	0378                	addi	a4,sp,396
 5a2:	0000                	unimp
 5a4:	a904                	fsd	fs1,16(a0)
 5a6:	1202                	slli	tp,tp,0x20
 5a8:	00000273          	0x273
 5ac:	014c                	addi	a1,sp,132
 5ae:	5118                	lw	a4,32(a0)
 5b0:	04000007          	0x4000007
 5b4:	02ad                	addi	t0,t0,11
 5b6:	e40c                	fsw	fa1,8(s0)
 5b8:	0008                	0x8
 5ba:	dc00                	sw	s0,56(s0)
 5bc:	1802                	slli	a6,a6,0x20
 5be:	020a                	slli	tp,tp,0x2
 5c0:	0000                	unimp
 5c2:	b204                	fsd	fs1,32(a2)
 5c4:	1002                	c.slli	zero,0x20
 5c6:	0668                	addi	a0,sp,780
 5c8:	0000                	unimp
 5ca:	02e0                	addi	s0,sp,332
 5cc:	ef18                	fsw	fa4,24(a4)
 5ce:	0001                	nop
 5d0:	0400                	addi	s0,sp,512
 5d2:	02b4                	addi	a3,sp,328
 5d4:	f00a                	fsw	ft2,32(sp)
 5d6:	0008                	0x8
 5d8:	ec00                	fsw	fs0,24(s0)
 5da:	0002                	c.slli64	zero
 5dc:	05bc040f          	0x5bc040f
 5e0:	0000                	unimp
 5e2:	0102                	c.slli64	sp
 5e4:	ea08                	fsw	fa0,16(a2)
 5e6:	0006                	c.slli	zero,0x1
 5e8:	1500                	addi	s0,sp,672
 5ea:	05bc                	addi	a5,sp,712
 5ec:	0000                	unimp
 5ee:	0444040f          	0x444040f
 5f2:	0000                	unimp
 5f4:	00009713          	slli	a4,ra,0x0
 5f8:	ec00                	fsw	fs0,24(s0)
 5fa:	0005                	c.nop	1
 5fc:	1400                	addi	s0,sp,544
 5fe:	0462                	slli	s0,s0,0x18
 600:	0000                	unimp
 602:	0514                	addi	a3,sp,640
 604:	0001                	nop
 606:	1400                	addi	s0,sp,544
 608:	05ec                	addi	a1,sp,716
 60a:	0000                	unimp
 60c:	2c14                	fld	fa3,24(s0)
 60e:	0000                	unimp
 610:	0000                	unimp
 612:	05c3040f          	0x5c3040f
 616:	0000                	unimp
 618:	ec15                	bnez	s0,654 <register_fini-0xfa20>
 61a:	0005                	c.nop	1
 61c:	0f00                	addi	s0,sp,912
 61e:	ce04                	sw	s1,24(a2)
 620:	0005                	c.nop	1
 622:	1300                	addi	s0,sp,416
 624:	0000008b          	0x8b
 628:	0000061b          	0x61b
 62c:	6214                	flw	fa3,0(a2)
 62e:	0004                	0x4
 630:	1400                	addi	s0,sp,544
 632:	0105                	addi	sp,sp,1
 634:	0000                	unimp
 636:	8b14                	0x8b14
 638:	0000                	unimp
 63a:	1400                	addi	s0,sp,544
 63c:	002c                	addi	a1,sp,8
 63e:	0000                	unimp
 640:	0f00                	addi	s0,sp,912
 642:	fd04                	fsw	fs1,56(a0)
 644:	0005                	c.nop	1
 646:	1300                	addi	s0,sp,416
 648:	002c                	addi	a1,sp,8
 64a:	0000                	unimp
 64c:	0635                	addi	a2,a2,13
 64e:	0000                	unimp
 650:	6214                	flw	fa3,0(a2)
 652:	0004                	0x4
 654:	1400                	addi	s0,sp,544
 656:	0105                	addi	sp,sp,1
 658:	0000                	unimp
 65a:	0f00                	addi	s0,sp,912
 65c:	2104                	fld	fs1,0(a0)
 65e:	0006                	c.slli	zero,0x1
 660:	0800                	addi	s0,sp,16
 662:	0000004f          	fnmadd.s	ft0,ft0,ft0,ft0,rne
 666:	0000064b          	fnmsub.s	fa2,ft0,ft0,ft0,rne
 66a:	3309                	jal	36c <register_fini-0xfd08>
 66c:	0000                	unimp
 66e:	0200                	addi	s0,sp,256
 670:	0800                	addi	s0,sp,16
 672:	0000004f          	fnmadd.s	ft0,ft0,ft0,ft0,rne
 676:	0000065b          	0x65b
 67a:	3309                	jal	37c <register_fini-0xfcf8>
 67c:	0000                	unimp
 67e:	0000                	unimp
 680:	0400                	addi	s0,sp,512
 682:	0226                	slli	tp,tp,0x9
 684:	0000                	unimp
 686:	2404                	fld	fs1,8(s0)
 688:	1a01                	addi	s4,s4,-32
 68a:	0301                	addi	t1,t1,0
 68c:	0000                	unimp
 68e:	3119                	jal	294 <register_fini-0xfde0>
 690:	0c000007          	0xc000007
 694:	2804                	fld	fs1,16(s0)
 696:	0801                	addi	a6,a6,0
 698:	06a1                	addi	a3,a3,8
 69a:	0000                	unimp
 69c:	00057117          	auipc	sp,0x57
 6a0:	0400                	addi	s0,sp,512
 6a2:	012a                	slli	sp,sp,0xa
 6a4:	a111                	j	aa8 <register_fini-0xf5cc>
 6a6:	0006                	c.slli	zero,0x1
 6a8:	0000                	unimp
 6aa:	00018617          	auipc	a2,0x18
 6ae:	0400                	addi	s0,sp,512
 6b0:	2c07012b          	0x2c07012b
 6b4:	0000                	unimp
 6b6:	0400                	addi	s0,sp,512
 6b8:	00054017          	auipc	zero,0x54
 6bc:	0400                	addi	s0,sp,512
 6be:	012c                	addi	a1,sp,136
 6c0:	0006a70b          	0x6a70b
 6c4:	0800                	addi	s0,sp,16
 6c6:	0f00                	addi	s0,sp,912
 6c8:	6804                	flw	fs1,16(s0)
 6ca:	0006                	c.slli	zero,0x1
 6cc:	0f00                	addi	s0,sp,912
 6ce:	5b04                	lw	s1,48(a4)
 6d0:	0006                	c.slli	zero,0x1
 6d2:	1900                	addi	s0,sp,176
 6d4:	000000bf 0144040e 	0x144040e000000bf
 6dc:	e608                	fsw	fa0,8(a2)
 6de:	0006                	c.slli	zero,0x1
 6e0:	1700                	addi	s0,sp,928
 6e2:	0669                	addi	a2,a2,26
 6e4:	0000                	unimp
 6e6:	4504                	lw	s1,8(a0)
 6e8:	1201                	addi	tp,tp,-32
 6ea:	06e6                	slli	a3,a3,0x19
 6ec:	0000                	unimp
 6ee:	1700                	addi	s0,sp,928
 6f0:	03dd                	addi	t2,t2,23
 6f2:	0000                	unimp
 6f4:	4604                	lw	s1,8(a2)
 6f6:	1201                	addi	tp,tp,-32
 6f8:	06e6                	slli	a3,a3,0x19
 6fa:	0000                	unimp
 6fc:	1706                	slli	a4,a4,0x21
 6fe:	000006ef          	jal	a3,6fe <register_fini-0xf976>
 702:	4704                	lw	s1,8(a4)
 704:	1201                	addi	tp,tp,-32
 706:	005d                	c.nop	23
 708:	0000                	unimp
 70a:	000c                	0xc
 70c:	5d08                	lw	a0,56(a0)
 70e:	0000                	unimp
 710:	f600                	fsw	fs0,40(a2)
 712:	0006                	c.slli	zero,0x1
 714:	0900                	addi	s0,sp,144
 716:	00000033          	add	zero,zero,zero
 71a:	0002                	c.slli64	zero
 71c:	d01a                	sw	t1,32(sp)
 71e:	8504                	0x8504
 720:	0702                	c.slli64	a4
 722:	0000080b          	0x80b
 726:	00043517          	auipc	a0,0x43
 72a:	0400                	addi	s0,sp,512
 72c:	33180287          	0x33180287
 730:	0000                	unimp
 732:	0000                	unimp
 734:	0006c417          	auipc	s0,0x6c
 738:	0400                	addi	s0,sp,512
 73a:	0288                	addi	a0,sp,320
 73c:	b612                	fsd	ft4,296(sp)
 73e:	0005                	c.nop	1
 740:	0400                	addi	s0,sp,512
 742:	00038d17          	auipc	s10,0x38
 746:	0400                	addi	s0,sp,512
 748:	0289                	addi	t0,t0,2
 74a:	0b10                	addi	a2,sp,400
 74c:	0008                	0x8
 74e:	0800                	addi	s0,sp,16
 750:	00078317          	auipc	t1,0x78
 754:	0400                	addi	s0,sp,512
 756:	028a                	slli	t0,t0,0x2
 758:	00019b17          	auipc	s6,0x19
 75c:	2400                	fld	fs0,8(s0)
 75e:	0002c217          	auipc	tp,0x2c
 762:	0400                	addi	s0,sp,512
 764:	2c0f028b          	0x2c0f028b
 768:	0000                	unimp
 76a:	4800                	lw	s0,16(s0)
 76c:	00056c17          	auipc	s8,0x56
 770:	0400                	addi	s0,sp,512
 772:	028c                	addi	a1,sp,320
 774:	252c                	fld	fa1,72(a0)
 776:	0000                	unimp
 778:	5000                	lw	s0,32(s0)
 77a:	00079b17          	auipc	s6,0x79
 77e:	0400                	addi	s0,sp,512
 780:	028d                	addi	t0,t0,3
 782:	ad1a                	fsd	ft6,152(sp)
 784:	0006                	c.slli	zero,0x1
 786:	5800                	lw	s0,48(s0)
 788:	00062017          	auipc	zero,0x62
 78c:	0400                	addi	s0,sp,512
 78e:	028e                	slli	t0,t0,0x3
 790:	f916                	fsw	ft5,176(sp)
 792:	0000                	unimp
 794:	6800                	flw	fs0,16(s0)
 796:	0007bb17          	auipc	s6,0x7b
 79a:	0400                	addi	s0,sp,512
 79c:	f916028f          	0xf916028f
 7a0:	0000                	unimp
 7a2:	7000                	flw	fs0,32(s0)
 7a4:	0001a417          	auipc	s0,0x1a
 7a8:	0400                	addi	s0,sp,512
 7aa:	0290                	addi	a2,sp,320
 7ac:	f916                	fsw	ft5,176(sp)
 7ae:	0000                	unimp
 7b0:	7800                	flw	fs0,48(s0)
 7b2:	00074717          	auipc	a4,0x74
 7b6:	0400                	addi	s0,sp,512
 7b8:	0291                	addi	t0,t0,4
 7ba:	1b10                	addi	a2,sp,432
 7bc:	0008                	0x8
 7be:	8000                	0x8000
 7c0:	00038117          	auipc	sp,0x38
 7c4:	0400                	addi	s0,sp,512
 7c6:	0292                	slli	t0,t0,0x4
 7c8:	2b10                	fld	fa2,16(a4)
 7ca:	0008                	0x8
 7cc:	8800                	0x8800
 7ce:	0000eb17          	auipc	s6,0xe
 7d2:	0400                	addi	s0,sp,512
 7d4:	2c0f0293          	addi	t0,t5,704 # 7177e <__global_pointer$+0x5ee8e>
 7d8:	0000                	unimp
 7da:	a000                	fsd	fs0,0(s0)
 7dc:	00027d17          	auipc	s10,0x27
 7e0:	0400                	addi	s0,sp,512
 7e2:	0294                	addi	a3,sp,320
 7e4:	f916                	fsw	ft5,176(sp)
 7e6:	0000                	unimp
 7e8:	a400                	fsd	fs0,8(s0)
 7ea:	00018d17          	auipc	s10,0x18
 7ee:	0400                	addi	s0,sp,512
 7f0:	0295                	addi	t0,t0,5
 7f2:	f916                	fsw	ft5,176(sp)
 7f4:	0000                	unimp
 7f6:	ac00                	fsd	fs0,24(s0)
 7f8:	00026c17          	auipc	s8,0x26
 7fc:	0400                	addi	s0,sp,512
 7fe:	0296                	slli	t0,t0,0x5
 800:	f916                	fsw	ft5,176(sp)
 802:	0000                	unimp
 804:	b400                	fsd	fs0,40(s0)
 806:	0000fe17          	auipc	t3,0xf
 80a:	0400                	addi	s0,sp,512
 80c:	f9160297          	auipc	t0,0xf9160
 810:	0000                	unimp
 812:	bc00                	fsd	fs0,56(s0)
 814:	00012a17          	auipc	s4,0x12
 818:	0400                	addi	s0,sp,512
 81a:	0298                	addi	a4,sp,320
 81c:	f916                	fsw	ft5,176(sp)
 81e:	0000                	unimp
 820:	c400                	sw	s0,8(s0)
 822:	00051f17          	auipc	t5,0x51
 826:	0400                	addi	s0,sp,512
 828:	0299                	addi	t0,t0,6
 82a:	2c08                	fld	fa0,24(s0)
 82c:	0000                	unimp
 82e:	cc00                	sw	s0,24(s0)
 830:	0800                	addi	s0,sp,16
 832:	05bc                	addi	a5,sp,712
 834:	0000                	unimp
 836:	0000081b          	0x81b
 83a:	3309                	jal	53c <register_fini-0xfb38>
 83c:	0000                	unimp
 83e:	1900                	addi	s0,sp,176
 840:	0800                	addi	s0,sp,16
 842:	05bc                	addi	a5,sp,712
 844:	0000                	unimp
 846:	0000082b          	0x82b
 84a:	3309                	jal	54c <register_fini-0xfb28>
 84c:	0000                	unimp
 84e:	0700                	addi	s0,sp,896
 850:	0800                	addi	s0,sp,16
 852:	05bc                	addi	a5,sp,712
 854:	0000                	unimp
 856:	0000083b          	0x83b
 85a:	3309                	jal	55c <register_fini-0xfb18>
 85c:	0000                	unimp
 85e:	1700                	addi	s0,sp,928
 860:	1a00                	addi	s0,sp,304
 862:	04f0                	addi	a2,sp,588
 864:	029e                	slli	t0,t0,0x7
 866:	00086207          	0x86207
 86a:	1700                	addi	s0,sp,928
 86c:	03ad                	addi	t2,t2,11
 86e:	0000                	unimp
 870:	a104                	fsd	fs1,0(a0)
 872:	1b02                	slli	s6,s6,0x20
 874:	0862                	slli	a6,a6,0x18
 876:	0000                	unimp
 878:	1700                	addi	s0,sp,928
 87a:	02d1                	addi	t0,t0,20
 87c:	0000                	unimp
 87e:	a204                	fsd	fs1,0(a2)
 880:	1802                	slli	a6,a6,0x20
 882:	0872                	slli	a6,a6,0x1c
 884:	0000                	unimp
 886:	0078                	addi	a4,sp,12
 888:	fb08                	fsw	fa0,48(a4)
 88a:	0002                	c.slli64	zero
 88c:	7200                	flw	fs0,32(a2)
 88e:	0008                	0x8
 890:	0900                	addi	s0,sp,144
 892:	00000033          	add	zero,zero,zero
 896:	001d                	c.nop	7
 898:	3308                	fld	fa0,32(a4)
 89a:	0000                	unimp
 89c:	8200                	0x8200
 89e:	0008                	0x8
 8a0:	0900                	addi	s0,sp,144
 8a2:	00000033          	add	zero,zero,zero
 8a6:	001d                	c.nop	7
 8a8:	8304f01b          	0x8304f01b
 8ac:	0302                	c.slli64	t1
 8ae:	000008a7          	0x8a7
 8b2:	621c                	flw	fa5,0(a2)
 8b4:	0006                	c.slli	zero,0x1
 8b6:	0400                	addi	s0,sp,512
 8b8:	029a                	slli	t0,t0,0x6
 8ba:	0006f60b          	0x6f60b
 8be:	1c00                	addi	s0,sp,560
 8c0:	0770                	addi	a2,sp,908
 8c2:	0000                	unimp
 8c4:	a304                	fsd	fs1,0(a4)
 8c6:	0b02                	c.slli64	s6
 8c8:	0000083b          	0x83b
 8cc:	0800                	addi	s0,sp,16
 8ce:	05bc                	addi	a5,sp,712
 8d0:	0000                	unimp
 8d2:	000008b7          	lui	a7,0x0
 8d6:	3309                	jal	5d8 <register_fini-0xfa9c>
 8d8:	0000                	unimp
 8da:	1800                	addi	s0,sp,48
 8dc:	1d00                	addi	s0,sp,688
 8de:	03ea                	slli	t2,t2,0x1a
 8e0:	0000                	unimp
 8e2:	08b7040f          	0x8b7040f
 8e6:	0000                	unimp
 8e8:	cd1e                	sw	t2,152(sp)
 8ea:	0008                	0x8
 8ec:	1400                	addi	s0,sp,544
 8ee:	0462                	slli	s0,s0,0x18
 8f0:	0000                	unimp
 8f2:	0f00                	addi	s0,sp,912
 8f4:	c204                	sw	s1,0(a2)
 8f6:	0008                	0x8
 8f8:	0f00                	addi	s0,sp,912
 8fa:	8504                	0x8504
 8fc:	0001                	nop
 8fe:	1e00                	addi	s0,sp,816
 900:	08e4                	addi	s1,sp,92
 902:	0000                	unimp
 904:	2c14                	fld	fa3,24(s0)
 906:	0000                	unimp
 908:	0000                	unimp
 90a:	08ea040f          	0x8ea040f
 90e:	0000                	unimp
 910:	08d9040f          	0x8d9040f
 914:	0000                	unimp
 916:	5b08                	lw	a0,48(a4)
 918:	0006                	c.slli	zero,0x1
 91a:	0000                	unimp
 91c:	0009                	c.nop	2
 91e:	0900                	addi	s0,sp,144
 920:	00000033          	add	zero,zero,zero
 924:	0002                	c.slli64	zero
 926:	131f 0007 0400      	0x4000007131f
 92c:	62170333          	0x62170333
 930:	0004                	0x4
 932:	1f00                	addi	s0,sp,944
 934:	070c                	addi	a1,sp,896
 936:	0000                	unimp
 938:	3404                	fld	fs1,40(s0)
 93a:	04681d03          	lh	s10,70(a6) # 7d54a <__global_pointer$+0x6ac5a>
 93e:	0000                	unimp
 940:	f208                	fsw	fa0,32(a2)
 942:	0005                	c.nop	1
 944:	2500                	fld	fs0,8(a0)
 946:	0009                	c.nop	2
 948:	2000                	fld	fs0,0(s0)
 94a:	1500                	addi	s0,sp,672
 94c:	091a                	slli	s2,s2,0x6
 94e:	0000                	unimp
 950:	5721                	li	a4,-24
 952:	0002                	c.slli64	zero
 954:	0600                	addi	s0,sp,768
 956:	2414                	fld	fa3,8(s0)
 958:	0925                	addi	s2,s2,9
 95a:	0000                	unimp
 95c:	6221                	lui	tp,0x8
 95e:	0005                	c.nop	1
 960:	0600                	addi	s0,sp,768
 962:	1515                	addi	a0,a0,-27
 964:	002c                	addi	a1,sp,8
 966:	0000                	unimp
 968:	0948040f          	0x948040f
 96c:	0000                	unimp
 96e:	00002c13          	slti	s8,zero,0
 972:	5c00                	lw	s0,56(s0)
 974:	0009                	c.nop	2
 976:	1400                	addi	s0,sp,544
 978:	095c                	addi	a5,sp,148
 97a:	0000                	unimp
 97c:	5c14                	lw	a3,56(s0)
 97e:	0009                	c.nop	2
 980:	0000                	unimp
 982:	0962040f          	0x962040f
 986:	0000                	unimp
 988:	2122                	fld	ft2,8(sp)
 98a:	0000048f          	0x48f
 98e:	b60e6707          	0xb60e6707
 992:	0005                	c.nop	1
 994:	2100                	fld	fs0,0(a0)
 996:	03bd                	addi	t2,t2,15
 998:	0000                	unimp
 99a:	1008                	addi	a0,sp,32
 99c:	00097b0f          	0x97b0f
 9a0:	0f00                	addi	s0,sp,912
 9a2:	b604                	fsd	fs1,40(a2)
 9a4:	0005                	c.nop	1
 9a6:	2100                	fld	fs0,0(a0)
 9a8:	0492                	slli	s1,s1,0x4
 9aa:	0000                	unimp
 9ac:	fc08                	fsw	fa0,56(s0)
 9ae:	b60e                	fsd	ft3,296(sp)
 9b0:	0005                	c.nop	1
 9b2:	2100                	fld	fs0,0(a0)
 9b4:	0000045b          	0x45b
 9b8:	fd08                	fsw	fa0,56(a0)
 9ba:	2c0c                	fld	fa1,24(s0)
 9bc:	0000                	unimp
 9be:	2100                	fld	fs0,0(a0)
 9c0:	06bd                	addi	a3,a3,15
 9c2:	0000                	unimp
 9c4:	fd08                	fsw	fa0,56(a0)
 9c6:	2c14                	fld	fa3,24(s0)
 9c8:	0000                	unimp
 9ca:	2100                	fld	fs0,0(a0)
 9cc:	07aa                	slli	a5,a5,0xa
 9ce:	0000                	unimp
 9d0:	fd08                	fsw	fa0,56(a0)
 9d2:	2c1c                	fld	fa5,24(s0)
 9d4:	0000                	unimp
 9d6:	2100                	fld	fs0,0(a0)
 9d8:	0410                	addi	a2,sp,512
 9da:	0000                	unimp
 9dc:	ff08                	fsw	fa0,56(a4)
 9de:	2c0c                	fld	fa1,24(s0)
 9e0:	0000                	unimp
 9e2:	2100                	fld	fs0,0(a0)
 9e4:	04be                	slli	s1,s1,0xf
 9e6:	0000                	unimp
 9e8:	9a09                	andi	a2,a2,-30
 9ea:	6416                	flw	fs0,68(sp)
 9ec:	0000                	unimp
 9ee:	2100                	fld	fs0,0(a0)
 9f0:	00d2                	slli	ra,ra,0x14
 9f2:	0000                	unimp
 9f4:	9b09                	andi	a4,a4,-30
 9f6:	2c15                	jal	c2a <register_fini-0xf44a>
 9f8:	0000                	unimp
 9fa:	0800                	addi	s0,sp,16
 9fc:	05b6                	slli	a1,a1,0xd
 9fe:	0000                	unimp
 a00:	09e5                	addi	s3,s3,25
 a02:	0000                	unimp
 a04:	3309                	jal	706 <register_fini-0xf96e>
 a06:	0000                	unimp
 a08:	0100                	addi	s0,sp,128
 a0a:	2100                	fld	fs0,0(a0)
 a0c:	019c                	addi	a5,sp,192
 a0e:	0000                	unimp
 a10:	9e09                	0x9e09
 a12:	0009d517          	auipc	a0,0x9d
 a16:	0500                	addi	s0,sp,640
 a18:	030c                	addi	a1,sp,384
 a1a:	0000                	unimp
 a1c:	2a0a                	fld	fs4,128(sp)
 a1e:	3316                	fld	ft6,352(sp)
 a20:	0000                	unimp
 a22:	0500                	addi	s0,sp,640
 a24:	0550                	addi	a2,sp,644
 a26:	0000                	unimp
 a28:	2f0a                	fld	ft10,128(sp)
 a2a:	0915                	addi	s2,s2,5
 a2c:	000a                	c.slli	zero,0x2
 a2e:	0f00                	addi	s0,sp,912
 a30:	0f04                	addi	s1,sp,912
 a32:	000a                	c.slli	zero,0x2
 a34:	1300                	addi	s0,sp,416
 a36:	09f1                	addi	s3,s3,28
 a38:	0000                	unimp
 a3a:	0a1e                	slli	s4,s4,0x7
 a3c:	0000                	unimp
 a3e:	5c14                	lw	a3,56(s0)
 a40:	0009                	c.nop	2
 a42:	0000                	unimp
 a44:	f205                	bnez	a2,964 <register_fini-0xf710>
 a46:	0a000007          	0xa000007
 a4a:	0f36                	slli	t5,t5,0xd
 a4c:	0942                	slli	s2,s2,0x10
 a4e:	0000                	unimp
 a50:	a721                	j	1158 <register_fini-0xef1c>
 a52:	0000                	unimp
 a54:	0a00                	addi	s0,sp,272
 a56:	09fd12bb          	0x9fd12bb
 a5a:	0000                	unimp
 a5c:	fc21                	bnez	s0,9b4 <register_fini-0xf6c0>
 a5e:	0006                	c.slli	zero,0x1
 a60:	0a00                	addi	s0,sp,272
 a62:	10be                	slli	ra,ra,0x2f
 a64:	0a1e                	slli	s4,s4,0x7
 a66:	0000                	unimp
 a68:	0002df23          	0x2df23
 a6c:	0700                	addi	s0,sp,896
 a6e:	3304                	fld	fs1,32(a4)
 a70:	0000                	unimp
 a72:	0b00                	addi	s0,sp,400
 a74:	0618                	addi	a4,sp,768
 a76:	0a7f                	0xa7f
 a78:	0000                	unimp
 a7a:	fa24                	fsw	fs1,112(a2)
 a7c:	0004                	0x4
 a7e:	0000                	unimp
 a80:	a224                	fsd	fs1,64(a2)
 a82:	01000003          	lb	zero,16(zero) # 10 <register_fini-0x10064>
 a86:	2a24                	fld	fs1,80(a2)
 a88:	0004                	0x4
 a8a:	0200                	addi	s0,sp,256
 a8c:	d224                	sw	s1,96(a2)
 a8e:	03000003          	lb	zero,48(zero) # 30 <register_fini-0x10044>
 a92:	f124                	fsw	fs1,96(a0)
 a94:	0004                	0x4
 a96:	0400                	addi	s0,sp,512
 a98:	b124                	fsd	fs1,96(a0)
 a9a:	05000007          	0x5000007
 a9e:	a024                	fsd	fs1,64(s0)
 aa0:	06000007          	0x6000007
 aa4:	2100                	fld	fs0,0(a0)
 aa6:	017c                	addi	a5,sp,140
 aa8:	0000                	unimp
 aaa:	421c210b          	0x421c210b
 aae:	000a                	c.slli	zero,0x2
 ab0:	2300                	fld	fs0,0(a4)
 ab2:	0442                	slli	s0,s0,0x10
 ab4:	0000                	unimp
 ab6:	00330407          	0x330407
 aba:	0000                	unimp
 abc:	b006230b          	0xb006230b
 ac0:	000a                	c.slli	zero,0x2
 ac2:	2400                	fld	fs0,8(s0)
 ac4:	0546                	slli	a0,a0,0x11
 ac6:	0000                	unimp
 ac8:	2400                	fld	fs0,8(s0)
 aca:	0510                	addi	a2,sp,640
 acc:	0000                	unimp
 ace:	2401                	jal	cce <register_fini-0xf3a6>
 ad0:	06d1                	addi	a3,a3,20
 ad2:	0000                	unimp
 ad4:	0002                	c.slli64	zero
 ad6:	8b21                	andi	a4,a4,8
 ad8:	0002                	c.slli64	zero
 ada:	0b00                	addi	s0,sp,400
 adc:	1e28                	addi	a0,sp,824
 ade:	00000a8b          	0xa8b
 ae2:	00010d23          	sb	zero,26(sp) # 387da <__global_pointer$+0x25eea>
 ae6:	0700                	addi	s0,sp,896
 ae8:	3304                	fld	fs1,32(a4)
 aea:	0000                	unimp
 aec:	0b00                	addi	s0,sp,400
 aee:	0adb062b          	0xadb062b
 af2:	0000                	unimp
 af4:	9f24                	0x9f24
 af6:	0006                	c.slli	zero,0x1
 af8:	0000                	unimp
 afa:	8d24                	0x8d24
 afc:	0006                	c.slli	zero,0x1
 afe:	0100                	addi	s0,sp,128
 b00:	2100                	fld	fs0,0(a0)
 b02:	0000023f bc2a2f0b 	0xbc2a2f0b0000023f
 b0a:	000a                	c.slli	zero,0x2
 b0c:	2100                	fld	fs0,0(a0)
 b0e:	03f5                	addi	t2,t2,29
 b10:	0000                	unimp
 b12:	290c                	fld	fa1,16(a0)
 b14:	251a                	fld	fa0,384(sp)
 b16:	0009                	c.nop	2
 b18:	2100                	fld	fs0,0(a0)
 b1a:	06ad                	addi	a3,a3,11
 b1c:	0000                	unimp
 b1e:	380c                	fld	fa1,48(s0)
 b20:	251a                	fld	fa0,384(sp)
 b22:	0009                	c.nop	2
 b24:	0500                	addi	s0,sp,640
 b26:	07e0                	addi	s0,sp,972
 b28:	0000                	unimp
 b2a:	7b0d                	lui	s6,0xfffe3
 b2c:	4f16                	lw	t5,68(sp)
 b2e:	0000                	unimp
 b30:	1500                	addi	s0,sp,672
 b32:	0aff                	0xaff
 b34:	0000                	unimp
 b36:	3805                	jal	366 <register_fini-0xfd0e>
 b38:	0002                	c.slli64	zero
 b3a:	0d00                	addi	s0,sp,656
 b3c:	0f80                	addi	s0,sp,976
 b3e:	002c                	addi	a1,sp,8
 b40:	0000                	unimp
 b42:	3705                	jal	a62 <register_fini-0xf612>
 b44:	0002                	c.slli64	zero
 b46:	0d00                	addi	s0,sp,656
 b48:	1681                	addi	a3,a3,-32
 b4a:	00000033          	add	zero,zero,zero
 b4e:	e305                	bnez	a4,b6e <register_fini-0xf506>
 b50:	0d000003          	lb	zero,208(zero) # d0 <register_fini-0xffa4>
 b54:	0f84                	addi	s1,sp,976
 b56:	003a                	c.slli	zero,0xe
 b58:	0000                	unimp
 b5a:	0402                	c.slli64	s0
 b5c:	6a04                	flw	fs1,16(a2)
 b5e:	0004                	0x4
 b60:	0200                	addi	s0,sp,256
 b62:	0308                	addi	a0,sp,384
 b64:	0462                	slli	s0,s0,0x18
 b66:	0000                	unimp
 b68:	0802                	c.slli64	a6
 b6a:	7504                	flw	fs1,40(a0)
 b6c:	0001                	nop
 b6e:	0200                	addi	s0,sp,256
 b70:	0310                	addi	a2,sp,384
 b72:	00dc                	addi	a5,sp,68
 b74:	0000                	unimp
 b76:	2002                	fld	ft0,0(sp)
 b78:	00016803          	0x16803
 b7c:	1900                	addi	s0,sp,176
 b7e:	000004ab          	0x4ab
 b82:	0d08                	addi	a0,sp,656
 b84:	01ed                	addi	gp,gp,27
 b86:	820a                	mv	tp,sp
 b88:	2500000b          	0x2500000b
 b8c:	6f6c                	flw	fa1,92(a4)
 b8e:	ed0d0077          	0xed0d0077
 b92:	1a01                	addi	s4,s4,-32
 b94:	0b10                	addi	a2,sp,400
 b96:	0000                	unimp
 b98:	1700                	addi	s0,sp,928
 b9a:	02a2                	slli	t0,t0,0x8
 b9c:	0000                	unimp
 b9e:	ed0d                	bnez	a0,bd8 <register_fini-0xf49c>
 ba0:	1f01                	addi	t5,t5,-32
 ba2:	0b10                	addi	a2,sp,400
 ba4:	0000                	unimp
 ba6:	0004                	0x4
 ba8:	f40d081b          	0xf40d081b
 bac:	0901                	addi	s2,s2,0
 bae:	0ba4                	addi	s1,sp,472
 bb0:	0000                	unimp
 bb2:	7326                	flw	ft6,104(sp)
 bb4:	0d00                	addi	s0,sp,656
 bb6:	01f6                	slli	gp,gp,0x1d
 bb8:	000b5713          	srli	a4,s6,0x0
 bbc:	2600                	fld	fs0,8(a2)
 bbe:	6c6c                	flw	fa1,92(s0)
 bc0:	0d00                	addi	s0,sp,656
 bc2:	280a01f7          	0x280a01f7
 bc6:	0000000b          	0xb
 bca:	1604                	addi	s1,sp,800
 bcc:	0d000003          	lb	zero,208(zero) # d0 <register_fini-0xffa4>
 bd0:	01f8                	addi	a4,sp,204
 bd2:	000b8203          	lb	tp,0(s7)
 bd6:	1500                	addi	s0,sp,672
 bd8:	0ba4                	addi	s1,sp,472
 bda:	0000                	unimp
 bdc:	0b08                	addi	a0,sp,400
 bde:	c600000b          	0xc600000b
 be2:	0900000b          	0x900000b
 be6:	00000033          	add	zero,zero,zero
 bea:	00ff                	0xff
 bec:	b615                	j	710 <register_fini-0xf964>
 bee:	1f00000b          	0x1f00000b
 bf2:	0000075b          	0x75b
 bf6:	fc0d                	bnez	s0,b30 <register_fini-0xf544>
 bf8:	1601                	addi	a2,a2,-32
 bfa:	0bc6                	slli	s7,s7,0x11
 bfc:	0000                	unimp
 bfe:	6e1f 0003 0d00      	0xd0000036e1f
 c04:	0202                	c.slli64	tp
 c06:	c616                	sw	t0,12(sp)
 c08:	2700000b          	0x2700000b
 c0c:	03b4                	addi	a3,sp,456
 c0e:	0000                	unimp
 c10:	2901                	jal	1020 <register_fini-0xf054>
 c12:	2801                	jal	c22 <register_fini-0xf452>
 c14:	dc00000b          	0xdc00000b
 c18:	9000010b          	0x9000010b
 c1c:	0000                	unimp
 c1e:	0100                	addi	s0,sp,128
 c20:	289c                	fld	fa5,16(s1)
 c22:	0075                	c.nop	29
 c24:	2901                	jal	1034 <register_fini-0xf040>
 c26:	2812                	fld	fa6,256(sp)
 c28:	0000000b          	0xb
 c2c:	0000                	unimp
 c2e:	2800                	fld	fs0,16(s0)
 c30:	0076                	c.slli	zero,0x1d
 c32:	2901                	jal	1042 <register_fini-0xf032>
 c34:	281c                	fld	fa5,16(s0)
 c36:	2800000b          	0x2800000b
 c3a:	0000                	unimp
 c3c:	2900                	fld	fs0,16(a0)
 c3e:	7575                	lui	a0,0xffffd
 c40:	0100                	addi	s0,sp,128
 c42:	0bb1112b          	0xbb1112b
 c46:	0000                	unimp
 c48:	7629                	lui	a2,0xfffea
 c4a:	0076                	c.slli	zero,0x1d
 c4c:	2c01                	jal	e5c <register_fini-0xf218>
 c4e:	b111                	j	852 <register_fini-0xf822>
 c50:	2900000b          	0x2900000b
 c54:	2d010077          	0x2d010077
 c58:	000ba40b          	0xba40b
 c5c:	2a00                	fld	fs0,16(a2)
 c5e:	01c2                	slli	gp,gp,0x10
 c60:	0000                	unimp
 c62:	2e01                	jal	f72 <register_fini-0xf102>
 c64:	1c0a                	slli	s8,s8,0x22
 c66:	5000000b          	0x5000000b
 c6a:	0000                	unimp
 c6c:	2a00                	fld	fs0,16(a2)
 c6e:	000006a7          	0x6a7
 c72:	2f01                	jal	1382 <register_fini-0xecf2>
 c74:	1c0a                	slli	s8,s8,0x22
 c76:	6e00000b          	0x6e00000b
 c7a:	0000                	unimp
 c7c:	2b00                	fld	fs0,16(a4)
 c7e:	00000577          	0x577
 c82:	3001                	jal	482 <register_fini-0xfbf2>
 c84:	1c0a                	slli	s8,s8,0x22
 c86:	0100000b          	0x100000b
 c8a:	2a5e                	fld	fs4,464(sp)
 c8c:	0322                	slli	t1,t1,0x8
 c8e:	0000                	unimp
 c90:	3101                	jal	890 <register_fini-0xf7e4>
 c92:	1c0a                	slli	s8,s8,0x22
 c94:	8c00000b          	0x8c00000b
 c98:	0000                	unimp
 c9a:	2a00                	fld	fs0,16(a2)
 c9c:	031e                	slli	t1,t1,0x7
 c9e:	0000                	unimp
 ca0:	3201                	jal	5a0 <register_fini-0xfad4>
 ca2:	1c0a                	slli	s8,s8,0x22
 ca4:	c100000b          	0xc100000b
 ca8:	0000                	unimp
 caa:	2a00                	fld	fs0,16(a2)
 cac:	02a0                	addi	s0,sp,328
 cae:	0000                	unimp
 cb0:	3301                	jal	9b0 <register_fini-0xf6c4>
 cb2:	1c0a                	slli	s8,s8,0x22
 cb4:	e400000b          	0xe400000b
 cb8:	0000                	unimp
 cba:	2a00                	fld	fs0,16(a2)
 cbc:	01ce                	slli	gp,gp,0x13
 cbe:	0000                	unimp
 cc0:	3401                	jal	6c0 <register_fini-0xf9b4>
 cc2:	1c0a                	slli	s8,s8,0x22
 cc4:	0e00000b          	0xe00000b
 cc8:	0001                	nop
 cca:	2b00                	fld	fs0,16(a4)
 ccc:	0152                	slli	sp,sp,0x14
 cce:	0000                	unimp
 cd0:	3501                	jal	ad0 <register_fini-0xf5a4>
 cd2:	1c0a                	slli	s8,s8,0x22
 cd4:	0100000b          	0x100000b
 cd8:	2a6d                	jal	e92 <register_fini-0xf1e2>
 cda:	000004eb          	0x4eb
 cde:	3601                	jal	7de <register_fini-0xf896>
 ce0:	1c0a                	slli	s8,s8,0x22
 ce2:	5300000b          	0x5300000b
 ce6:	0001                	nop
 ce8:	2c00                	fld	fs0,24(s0)
 cea:	0c3c                	addi	a5,sp,536
 cec:	0001                	nop
 cee:	0004                	0x4
 cf0:	0000                	unimp
 cf2:	0ced                	addi	s9,s9,27
 cf4:	0000                	unimp
 cf6:	0004042b          	0x4042b
 cfa:	0100                	addi	s0,sp,128
 cfc:	1b50                	addi	a2,sp,436
 cfe:	0b1c                	addi	a5,sp,400
 d00:	0000                	unimp
 d02:	5a01                	li	s4,-32
 d04:	00040a2b          	0x40a2b
 d08:	0100                	addi	s0,sp,128
 d0a:	1b50                	addi	a2,sp,436
 d0c:	0b1c                	addi	a5,sp,400
 d0e:	0000                	unimp
 d10:	5b01                	li	s6,-32
 d12:	2d00                	fld	fs0,24(a0)
 d14:	0c48                	addi	a0,sp,532
 d16:	0001                	nop
 d18:	000c                	0xc
 d1a:	0000                	unimp
 d1c:	0004042b          	0x4042b
 d20:	0100                	addi	s0,sp,128
 d22:	0b1c1153          	fsub.d	ft2,fs8,fa7,rtz
 d26:	0000                	unimp
 d28:	5a01                	li	s4,-32
 d2a:	00040a2b          	0x40a2b
 d2e:	0100                	addi	s0,sp,128
 d30:	0b1c1153          	fsub.d	ft2,fs8,fa7,rtz
 d34:	0000                	unimp
 d36:	5b01                	li	s6,-32
 d38:	0000                	unimp
	...

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
  16:	2501                	jal	616 <register_fini-0xfa5e>
  18:	130e                	slli	t1,t1,0x23
  1a:	1b0e030b          	0x1b0e030b
  1e:	110e                	slli	sp,sp,0x23
  20:	1201                	addi	tp,tp,-32
  22:	1006                	c.slli	zero,0x21
  24:	02000017          	auipc	zero,0x2000
  28:	0024                	addi	s1,sp,8
  2a:	0b3e0b0b          	0xb3e0b0b
  2e:	00000e03          	lb	t3,0(zero) # 0 <register_fini-0x10074>
  32:	0b002403          	lw	s0,176(zero) # b0 <register_fini-0xffc4>
  36:	030b3e0b          	0x30b3e0b
  3a:	0008                	0x8
  3c:	0400                	addi	s0,sp,512
  3e:	0016                	c.slli	zero,0x5
  40:	0b3a0e03          	lb	t3,179(s4) # 128c7 <__BSS_END__+0x383>
  44:	0b39053b          	0xb39053b
  48:	1349                	addi	t1,t1,-14
  4a:	0000                	unimp
  4c:	1605                	addi	a2,a2,-31
  4e:	0300                	addi	s0,sp,384
  50:	3a0e                	fld	fs4,224(sp)
  52:	390b3b0b          	0x390b3b0b
  56:	0013490b          	0x13490b
  5a:	0600                	addi	s0,sp,768
  5c:	0b0b0117          	auipc	sp,0xb0b0
  60:	0b3a                	slli	s6,s6,0xe
  62:	0b390b3b          	0xb390b3b
  66:	1301                	addi	t1,t1,-32
  68:	0000                	unimp
  6a:	03000d07          	0x3000d07
  6e:	3a0e                	fld	fs4,224(sp)
  70:	390b3b0b          	0x390b3b0b
  74:	0013490b          	0x13490b
  78:	0800                	addi	s0,sp,16
  7a:	0101                	addi	sp,sp,0
  7c:	1349                	addi	t1,t1,-14
  7e:	1301                	addi	t1,t1,-32
  80:	0000                	unimp
  82:	2109                	jal	484 <register_fini-0xfbf0>
  84:	4900                	lw	s0,16(a0)
  86:	000b2f13          	slti	t5,s6,0
  8a:	0a00                	addi	s0,sp,272
  8c:	0b0b0113          	addi	sp,s6,176 # fffe30b0 <__global_pointer$+0xfffd07c0>
  90:	0b3a                	slli	s6,s6,0xe
  92:	0b390b3b          	0xb390b3b
  96:	1301                	addi	t1,t1,-32
  98:	0000                	unimp
  9a:	03000d0b          	0x3000d0b
  9e:	3a0e                	fld	fs4,224(sp)
  a0:	390b3b0b          	0x390b3b0b
  a4:	3813490b          	0x3813490b
  a8:	0c00000b          	0xc00000b
  ac:	0b0b000f          	0xb0b000f
  b0:	0000                	unimp
  b2:	130d                	addi	t1,t1,-29
  b4:	0301                	addi	t1,t1,0
  b6:	0b0e                	slli	s6,s6,0x3
  b8:	3b0b3a0b          	0x3b0b3a0b
  bc:	010b390b          	0x10b390b
  c0:	0e000013          	li	zero,224
  c4:	000d                	c.nop	3
  c6:	0b3a0803          	lb	a6,179(s4)
  ca:	0b390b3b          	0xb390b3b
  ce:	1349                	addi	t1,t1,-14
  d0:	0b38                	addi	a4,sp,408
  d2:	0000                	unimp
  d4:	0b000f0f          	0xb000f0f
  d8:	0013490b          	0x13490b
  dc:	1000                	addi	s0,sp,32
  de:	0e030113          	addi	sp,t1,224 # 78830 <__global_pointer$+0x65f40>
  e2:	0b3a050b          	0xb3a050b
  e6:	0b390b3b          	0xb390b3b
  ea:	1301                	addi	t1,t1,-32
  ec:	0000                	unimp
  ee:	0d11                	addi	s10,s10,4
  f0:	0300                	addi	s0,sp,384
  f2:	3a0e                	fld	fs4,224(sp)
  f4:	390b3b0b          	0x390b3b0b
  f8:	3813490b          	0x3813490b
  fc:	0005                	c.nop	1
  fe:	1200                	addi	s0,sp,288
 100:	0015                	c.nop	5
 102:	00001927          	0x1927
 106:	27011513          	0x27011513
 10a:	4919                	li	s2,6
 10c:	00130113          	addi	sp,t1,1
 110:	1400                	addi	s0,sp,544
 112:	0005                	c.nop	1
 114:	1349                	addi	t1,t1,-14
 116:	0000                	unimp
 118:	2615                	jal	43c <register_fini-0xfc38>
 11a:	4900                	lw	s0,16(a0)
 11c:	16000013          	li	zero,352
 120:	0e030113          	addi	sp,t1,224
 124:	0b3a050b          	0xb3a050b
 128:	0b39053b          	0xb39053b
 12c:	1301                	addi	t1,t1,-32
 12e:	0000                	unimp
 130:	03000d17          	auipc	s10,0x3000
 134:	3a0e                	fld	fs4,224(sp)
 136:	39053b0b          	0x39053b0b
 13a:	3813490b          	0x3813490b
 13e:	1800000b          	0x1800000b
 142:	000d                	c.nop	3
 144:	0b3a0e03          	lb	t3,179(s4)
 148:	0b39053b          	0xb39053b
 14c:	1349                	addi	t1,t1,-14
 14e:	0538                	addi	a4,sp,648
 150:	0000                	unimp
 152:	1319                	addi	t1,t1,-26
 154:	0301                	addi	t1,t1,0
 156:	0b0e                	slli	s6,s6,0x3
 158:	3b0b3a0b          	0x3b0b3a0b
 15c:	3905                	jal	fffffd8c <__global_pointer$+0xfffed49c>
 15e:	0013010b          	0x13010b
 162:	1a00                	addi	s0,sp,304
 164:	0b0b0113          	addi	sp,s6,176
 168:	0b3a                	slli	s6,s6,0xe
 16a:	0b39053b          	0xb39053b
 16e:	1301                	addi	t1,t1,-32
 170:	0000                	unimp
 172:	0b01171b          	0xb01171b
 176:	3b0b3a0b          	0x3b0b3a0b
 17a:	3905                	jal	fffffdaa <__global_pointer$+0xfffed4ba>
 17c:	0013010b          	0x13010b
 180:	1c00                	addi	s0,sp,560
 182:	000d                	c.nop	3
 184:	0b3a0e03          	lb	t3,179(s4)
 188:	0b39053b          	0xb39053b
 18c:	1349                	addi	t1,t1,-14
 18e:	0000                	unimp
 190:	131d                	addi	t1,t1,-25
 192:	0300                	addi	s0,sp,384
 194:	3c0e                	fld	fs8,224(sp)
 196:	0019                	c.nop	6
 198:	1e00                	addi	s0,sp,816
 19a:	0115                	addi	sp,sp,5
 19c:	13011927          	0x13011927
 1a0:	0000                	unimp
 1a2:	341f 0300 3a0e      	0x3a0e0300341f
 1a8:	39053b0b          	0x39053b0b
 1ac:	3f13490b          	0x3f13490b
 1b0:	3c19                	jal	fffffbc6 <__global_pointer$+0xfffed2d6>
 1b2:	0019                	c.nop	6
 1b4:	2000                	fld	fs0,0(s0)
 1b6:	0021                	c.nop	8
 1b8:	0000                	unimp
 1ba:	3421                	jal	fffffbc2 <__global_pointer$+0xfffed2d2>
 1bc:	0300                	addi	s0,sp,384
 1be:	3a0e                	fld	fs4,224(sp)
 1c0:	390b3b0b          	0x390b3b0b
 1c4:	3f13490b          	0x3f13490b
 1c8:	3c19                	jal	fffffbde <__global_pointer$+0xfffed2ee>
 1ca:	0019                	c.nop	6
 1cc:	2200                	fld	fs0,0(a2)
 1ce:	0026                	c.slli	zero,0x9
 1d0:	0000                	unimp
 1d2:	03010423          	sb	a6,40(sp) # b0b0084 <__global_pointer$+0xb09d794>
 1d6:	3e0e                	fld	ft8,224(sp)
 1d8:	490b0b0b          	0x490b0b0b
 1dc:	3b0b3a13          	sltiu	s4,s6,944
 1e0:	010b390b          	0x10b390b
 1e4:	24000013          	li	zero,576
 1e8:	0028                	addi	a0,sp,8
 1ea:	0b1c0e03          	lb	t3,177(s8) # 268a9 <__global_pointer$+0x13fb9>
 1ee:	0000                	unimp
 1f0:	0d25                	addi	s10,s10,9
 1f2:	0300                	addi	s0,sp,384
 1f4:	3a08                	fld	fa0,48(a2)
 1f6:	39053b0b          	0x39053b0b
 1fa:	3813490b          	0x3813490b
 1fe:	2600000b          	0x2600000b
 202:	000d                	c.nop	3
 204:	0b3a0803          	lb	a6,179(s4)
 208:	0b39053b          	0xb39053b
 20c:	1349                	addi	t1,t1,-14
 20e:	0000                	unimp
 210:	3f012e27          	fsw	fa6,1020(sp)
 214:	0319                	addi	t1,t1,6
 216:	3a0e                	fld	fs4,224(sp)
 218:	390b3b0b          	0x390b3b0b
 21c:	4919270b          	0x4919270b
 220:	12011113          	0x12011113
 224:	4006                	0x4006
 226:	9718                	0x9718
 228:	1942                	slli	s2,s2,0x30
 22a:	0000                	unimp
 22c:	0528                	addi	a0,sp,648
 22e:	0300                	addi	s0,sp,384
 230:	3a08                	fld	fa0,48(a2)
 232:	390b3b0b          	0x390b3b0b
 236:	0213490b          	0x213490b
 23a:	29000017          	auipc	zero,0x29000
 23e:	0034                	addi	a3,sp,8
 240:	0b3a0803          	lb	a6,179(s4)
 244:	0b390b3b          	0xb390b3b
 248:	1349                	addi	t1,t1,-14
 24a:	0000                	unimp
 24c:	342a                	fld	fs0,168(sp)
 24e:	0300                	addi	s0,sp,384
 250:	3a0e                	fld	fs4,224(sp)
 252:	390b3b0b          	0x390b3b0b
 256:	0213490b          	0x213490b
 25a:	2b000017          	auipc	zero,0x2b000
 25e:	0034                	addi	a3,sp,8
 260:	0b3a0e03          	lb	t3,179(s4)
 264:	0b390b3b          	0xb390b3b
 268:	1349                	addi	t1,t1,-14
 26a:	1802                	slli	a6,a6,0x20
 26c:	0000                	unimp
 26e:	0b2c                	addi	a1,sp,408
 270:	1101                	addi	sp,sp,-32
 272:	1201                	addi	tp,tp,-32
 274:	0106                	slli	sp,sp,0x1
 276:	2d000013          	li	zero,720
 27a:	0111010b          	0x111010b
 27e:	0612                	slli	a2,a2,0x4
 280:	0000                	unimp
	...

Disassembly of section .debug_line:

00000000 <.debug_line>:
   0:	0000008f          	0x8f
   4:	00490003          	lb	zero,4(s2) # 7c54e <__global_pointer$+0x69c5e>
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
  4a:	3369                	jal	fffffdd4 <__global_pointer$+0xfffed4e4>
  4c:	532e                	lw	t1,232(sp)
  4e:	0100                	addi	s0,sp,128
  50:	0000                	unimp
  52:	0000                	unimp
  54:	0205                	addi	tp,tp,1
  56:	0bb8                	addi	a4,sp,472
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
  92:	ff01                	bnez	a4,ffffffaa <__global_pointer$+0xfffed6ba>
  94:	03000003          	lb	zero,48(zero) # 30 <register_fini-0x10044>
  98:	0a00                	addi	s0,sp,272
  9a:	0002                	c.slli64	zero
  9c:	0100                	addi	s0,sp,128
  9e:	fb01                	bnez	a4,ffffffae <__global_pointer$+0xfffed6be>
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
  cc:	69666e6f          	jal	t3,66762 <__global_pointer$+0x53e72>
  d0:	69722f67          	0x69722f67
  d4:	00766373          	csrrsi	t1,0x7,12
  d8:	6d6f682f          	0x6d6f682f
  dc:	2f65                	jal	894 <register_fini-0xf7e0>
  de:	6d6a                	flw	fs10,152(sp)
  e0:	6579                	lui	a0,0x1e
  e2:	6f6f742f          	0x6f6f742f
  e6:	736c                	flw	fa1,100(a4)
  e8:	7369722f          	0x7369722f
  ec:	672d7663          	bgeu	s10,s2,758 <register_fini-0xf91c>
  f0:	756e                	flw	fa0,248(sp)
  f2:	742d                	lui	s0,0xfffeb
  f4:	636c6f6f          	jal	t5,c672a <__global_pointer$+0xb3e3a>
  f8:	6168                	flw	fa0,68(a0)
  fa:	6e69                	lui	t3,0x1a
  fc:	6975622f          	0x6975622f
 100:	646c                	flw	fa1,76(s0)
 102:	6975622f          	0x6975622f
 106:	646c                	flw	fa1,76(s0)
 108:	672d                	lui	a4,0xb
 10a:	6e2d6363          	bltu	s10,sp,7f0 <register_fini-0xf884>
 10e:	7765                	lui	a4,0xffff9
 110:	696c                	flw	fa1,84(a0)
 112:	2d62                	fld	fs10,24(sp)
 114:	67617473          	csrrci	s0,0x676,2
 118:	3265                	jal	fffffac0 <__global_pointer$+0xfffed1d0>
 11a:	6363672f          	0x6363672f
 11e:	636e692f          	0x636e692f
 122:	756c                	flw	fa1,108(a0)
 124:	6564                	flw	fs1,76(a0)
 126:	2f00                	fld	fs0,24(a4)
 128:	2f74706f          	j	47c1e <__global_pointer$+0x3532e>
 12c:	6972                	flw	fs2,28(sp)
 12e:	33766373          	csrrsi	t1,mhpmevent23,12
 132:	6932                	flw	fs2,12(sp)
 134:	7369722f          	0x7369722f
 138:	32337663          	bgeu	t1,gp,464 <register_fini-0xfc10>
 13c:	752d                	lui	a0,0xfffeb
 13e:	6b6e                	flw	fs6,216(sp)
 140:	6f6e                	flw	ft10,216(sp)
 142:	652d6e77          	0x652d6e77
 146:	666c                	flw	fa1,76(a2)
 148:	636e692f          	0x636e692f
 14c:	756c                	flw	fa1,108(a0)
 14e:	6564                	flw	fs1,76(a0)
 150:	7379732f          	0x7379732f
 154:	2f00                	fld	fs0,24(a4)
 156:	2f74706f          	j	47c4c <__global_pointer$+0x3535c>
 15a:	6972                	flw	fs2,28(sp)
 15c:	33766373          	csrrsi	t1,mhpmevent23,12
 160:	6932                	flw	fs2,12(sp)
 162:	7369722f          	0x7369722f
 166:	32337663          	bgeu	t1,gp,492 <register_fini-0xfbe2>
 16a:	752d                	lui	a0,0xfffeb
 16c:	6b6e                	flw	fs6,216(sp)
 16e:	6f6e                	flw	ft10,216(sp)
 170:	652d6e77          	0x652d6e77
 174:	666c                	flw	fa1,76(a2)
 176:	636e692f          	0x636e692f
 17a:	756c                	flw	fa1,108(a0)
 17c:	6564                	flw	fs1,76(a0)
 17e:	2e00                	fld	fs0,24(a2)
 180:	2f2e                	fld	ft10,200(sp)
 182:	2e2e                	fld	ft8,200(sp)
 184:	2f2e2e2f          	0x2f2e2e2f
 188:	2e2e                	fld	ft8,200(sp)
 18a:	7369722f          	0x7369722f
 18e:	672d7663          	bgeu	s10,s2,7fa <register_fini-0xf87a>
 192:	6c2f6363          	bltu	t5,sp,858 <register_fini-0xf81c>
 196:	6269                	lui	tp,0x1a
 198:	2f636367          	0x2f636367
 19c:	2e2e                	fld	ft8,200(sp)
 19e:	636e692f          	0x636e692f
 1a2:	756c                	flw	fa1,108(a0)
 1a4:	6564                	flw	fs1,76(a0)
 1a6:	2e00                	fld	fs0,24(a2)
 1a8:	2f2e                	fld	ft10,200(sp)
 1aa:	2e2e                	fld	ft8,200(sp)
 1ac:	2f2e2e2f          	0x2f2e2e2f
 1b0:	2e2e                	fld	ft8,200(sp)
 1b2:	7369722f          	0x7369722f
 1b6:	672d7663          	bgeu	s10,s2,822 <register_fini-0xf852>
 1ba:	6c2f6363          	bltu	t5,sp,880 <register_fini-0xf7f4>
 1be:	6269                	lui	tp,0x1a
 1c0:	2f636367          	0x2f636367
 1c4:	2e2e                	fld	ft8,200(sp)
 1c6:	6363672f          	0x6363672f
 1ca:	6e6f632f          	0x6e6f632f
 1ce:	6966                	flw	fs2,88(sp)
 1d0:	69722f67          	0x69722f67
 1d4:	00766373          	csrrsi	t1,0x7,12
 1d8:	2e2e                	fld	ft8,200(sp)
 1da:	2f2e2e2f          	0x2f2e2e2f
 1de:	2f2e                	fld	ft10,200(sp)
 1e0:	00636367          	0x636367
 1e4:	2e2e                	fld	ft8,200(sp)
 1e6:	2f2e2e2f          	0x2f2e2e2f
 1ea:	2e2e                	fld	ft8,200(sp)
 1ec:	2f2e2e2f          	0x2f2e2e2f
 1f0:	6972                	flw	fs2,28(sp)
 1f2:	2d766373          	csrrsi	t1,0x2d7,12
 1f6:	2f636367          	0x2f636367
 1fa:	696c                	flw	fa1,84(a0)
 1fc:	6762                	flw	fa4,24(sp)
 1fe:	00006363          	bltu	zero,zero,204 <register_fini-0xfe70>
 202:	756d                	lui	a0,0xffffb
 204:	746c                	flw	fa1,108(s0)
 206:	3369                	jal	ffffff90 <__global_pointer$+0xfffed6a0>
 208:	632e                	flw	ft6,200(sp)
 20a:	0100                	addi	s0,sp,128
 20c:	0000                	unimp
 20e:	64647473          	csrrci	s0,0x646,8
 212:	6665                	lui	a2,0x19
 214:	682e                	flw	fa6,200(sp)
 216:	0200                	addi	s0,sp,256
 218:	0000                	unimp
 21a:	745f 7079 7365      	0x73657079745f
 220:	682e                	flw	fa6,200(sp)
 222:	0300                	addi	s0,sp,384
 224:	0000                	unimp
 226:	6572                	flw	fa0,28(sp)
 228:	6e65                	lui	t3,0x19
 22a:	2e74                	fld	fa3,216(a2)
 22c:	0068                	addi	a0,sp,12
 22e:	6c000003          	lb	zero,1728(zero) # 6c0 <register_fini-0xf9b4>
 232:	2e6b636f          	jal	t1,b6518 <__global_pointer$+0xa3c28>
 236:	0068                	addi	a0,sp,12
 238:	65000003          	lb	zero,1616(zero) # 650 <register_fini-0xfa24>
 23c:	7272                	flw	ft4,60(sp)
 23e:	6f6e                	flw	ft10,216(sp)
 240:	682e                	flw	fa6,200(sp)
 242:	0300                	addi	s0,sp,384
 244:	0000                	unimp
 246:	6c647473          	csrrci	s0,0x6c6,8
 24a:	6269                	lui	tp,0x1a
 24c:	682e                	flw	fa6,200(sp)
 24e:	0400                	addi	s0,sp,512
 250:	0000                	unimp
 252:	6e75                	lui	t3,0x1d
 254:	7369                	lui	t1,0xffffa
 256:	6474                	flw	fa3,76(s0)
 258:	682e                	flw	fa6,200(sp)
 25a:	0300                	addi	s0,sp,384
 25c:	0000                	unimp
 25e:	6974                	flw	fa3,84(a0)
 260:	656d                	lui	a0,0x1b
 262:	682e                	flw	fa6,200(sp)
 264:	0400                	addi	s0,sp,512
 266:	0000                	unimp
 268:	6168                	flw	fa0,68(a0)
 26a:	61746873          	csrrsi	a6,0x617,8
 26e:	2e62                	fld	ft8,24(sp)
 270:	0068                	addi	a0,sp,12
 272:	0005                	c.nop	1
 274:	7200                	flw	fs0,32(a2)
 276:	7369                	lui	t1,0xffffa
 278:	6f2d7663          	bgeu	s10,s2,964 <register_fini-0xf710>
 27c:	7470                	flw	fa2,108(s0)
 27e:	00682e73          	csrrs	t3,0x6,a6
 282:	0006                	c.slli	zero,0x1
 284:	6900                	flw	fs0,16(a0)
 286:	736e                	flw	ft6,248(sp)
 288:	2d6e                	fld	fs10,216(sp)
 28a:	736e6f63          	bltu	t3,s6,9c8 <register_fini-0xf6ac>
 28e:	6174                	flw	fa3,68(a0)
 290:	746e                	flw	fs0,248(sp)
 292:	00682e73          	csrrs	t3,0x6,a6
 296:	6c000007          	0x6c000007
 29a:	6269                	lui	tp,0x1a
 29c:	32636367          	0x32636367
 2a0:	682e                	flw	fa6,200(sp)
 2a2:	0800                	addi	s0,sp,16
 2a4:	0000                	unimp
 2a6:	0500                	addi	s0,sp,640
 2a8:	0001                	nop
 2aa:	0205                	addi	tp,tp,1
 2ac:	0bdc                	addi	a5,sp,468
 2ae:	0001                	nop
 2b0:	05012903          	lw	s2,80(sp)
 2b4:	09010303          	lb	t1,144(sp)
 2b8:	0000                	unimp
 2ba:	0301                	addi	t1,t1,0
 2bc:	0901                	addi	s2,s2,0
 2be:	0000                	unimp
 2c0:	0301                	addi	t1,t1,0
 2c2:	0901                	addi	s2,s2,0
 2c4:	0000                	unimp
 2c6:	0301                	addi	t1,t1,0
 2c8:	0901                	addi	s2,s2,0
 2ca:	0000                	unimp
 2cc:	0501                	addi	a0,a0,0
 2ce:	0601                	addi	a2,a2,0
 2d0:	00097c03          	0x97c03
 2d4:	0100                	addi	s0,sp,128
 2d6:	0a05                	addi	s4,s4,1
 2d8:	14090403          	lb	s0,320(s2)
 2dc:	0100                	addi	s0,sp,128
 2de:	0305                	addi	t1,t1,1
 2e0:	0306                	slli	t1,t1,0x1
 2e2:	0901                	addi	s2,s2,0
 2e4:	0004                	0x4
 2e6:	0301                	addi	t1,t1,0
 2e8:	0901                	addi	s2,s2,0
 2ea:	0000                	unimp
 2ec:	0301                	addi	t1,t1,0
 2ee:	0901                	addi	s2,s2,0
 2f0:	0000                	unimp
 2f2:	0301                	addi	t1,t1,0
 2f4:	0901                	addi	s2,s2,0
 2f6:	0000                	unimp
 2f8:	0301                	addi	t1,t1,0
 2fa:	0901                	addi	s2,s2,0
 2fc:	0000                	unimp
 2fe:	0301                	addi	t1,t1,0
 300:	0901                	addi	s2,s2,0
 302:	0000                	unimp
 304:	0501                	addi	a0,a0,0
 306:	060a                	slli	a2,a2,0x2
 308:	00097b03          	0x97b03
 30c:	0100                	addi	s0,sp,128
 30e:	04090503          	lb	a0,64(s2)
 312:	0100                	addi	s0,sp,128
 314:	04097f03          	0x4097f03
 318:	0100                	addi	s0,sp,128
 31a:	04097e03          	0x4097e03
 31e:	0100                	addi	s0,sp,128
 320:	0305                	addi	t1,t1,1
 322:	0306                	slli	t1,t1,0x1
 324:	0904                	addi	s1,sp,144
 326:	0004                	0x4
 328:	0301                	addi	t1,t1,0
 32a:	0901                	addi	s2,s2,0
 32c:	0000                	unimp
 32e:	0301                	addi	t1,t1,0
 330:	0904                	addi	s1,sp,144
 332:	0000                	unimp
 334:	0501                	addi	a0,a0,0
 336:	09020307          	0x9020307
 33a:	0000                	unimp
 33c:	0301                	addi	t1,t1,0
 33e:	0901                	addi	s2,s2,0
 340:	0000                	unimp
 342:	0501                	addi	a0,a0,0
 344:	0611                	addi	a2,a2,4
 346:	00090203          	lb	tp,0(s2)
 34a:	0100                	addi	s0,sp,128
 34c:	1405                	addi	s0,s0,-31
 34e:	04097e03          	0x4097e03
 352:	0100                	addi	s0,sp,128
 354:	0705                	addi	a4,a4,1
 356:	0306                	slli	t1,t1,0x1
 358:	0901                	addi	s2,s2,0
 35a:	0004                	0x4
 35c:	0301                	addi	t1,t1,0
 35e:	0901                	addi	s2,s2,0
 360:	0000                	unimp
 362:	0501                	addi	a0,a0,0
 364:	060a                	slli	a2,a2,0x2
 366:	00090003          	lb	zero,0(s2)
 36a:	0100                	addi	s0,sp,128
 36c:	1105                	addi	sp,sp,-31
 36e:	04097d03          	0x4097d03
 372:	0100                	addi	s0,sp,128
 374:	0405                	addi	s0,s0,1
 376:	0306                	slli	t1,t1,0x1
 378:	0905                	addi	s2,s2,1
 37a:	0004                	0x4
 37c:	0301                	addi	t1,t1,0
 37e:	0901                	addi	s2,s2,0
 380:	0000                	unimp
 382:	0301                	addi	t1,t1,0
 384:	0901                	addi	s2,s2,0
 386:	0000                	unimp
 388:	0501                	addi	a0,a0,0
 38a:	0616                	slli	a2,a2,0x5
 38c:	00097e03          	0x97e03
 390:	0100                	addi	s0,sp,128
 392:	1205                	addi	tp,tp,-31
 394:	04097d03          	0x4097d03
 398:	0100                	addi	s0,sp,128
 39a:	0b05                	addi	s6,s6,1
 39c:	04090503          	lb	a0,64(s2)
 3a0:	0100                	addi	s0,sp,128
 3a2:	0a05                	addi	s4,s4,1
 3a4:	04097f03          	0x4097f03
 3a8:	0100                	addi	s0,sp,128
 3aa:	0705                	addi	a4,a4,1
 3ac:	0306                	slli	t1,t1,0x1
 3ae:	00040903          	lb	s2,0(s0) # fffeb000 <__global_pointer$+0xfffd8710>
 3b2:	0501                	addi	a0,a0,0
 3b4:	0611                	addi	a2,a2,4
 3b6:	00090003          	lb	zero,0(s2)
 3ba:	0100                	addi	s0,sp,128
 3bc:	0705                	addi	a4,a4,1
 3be:	0306                	slli	t1,t1,0x1
 3c0:	0901                	addi	s2,s2,0
 3c2:	0004                	0x4
 3c4:	0501                	addi	a0,a0,0
 3c6:	060d                	addi	a2,a2,3
 3c8:	00090003          	lb	zero,0(s2)
 3cc:	0100                	addi	s0,sp,128
 3ce:	0705                	addi	a4,a4,1
 3d0:	0306                	slli	t1,t1,0x1
 3d2:	0901                	addi	s2,s2,0
 3d4:	0004                	0x4
 3d6:	0301                	addi	t1,t1,0
 3d8:	0901                	addi	s2,s2,0
 3da:	0000                	unimp
 3dc:	0501                	addi	a0,a0,0
 3de:	0612                	slli	a2,a2,0x4
 3e0:	00090003          	lb	zero,0(s2)
 3e4:	0100                	addi	s0,sp,128
 3e6:	0905                	addi	s2,s2,1
 3e8:	0306                	slli	t1,t1,0x1
 3ea:	0902                	c.slli64	s2
 3ec:	0008                	0x8
 3ee:	0501                	addi	a0,a0,0
 3f0:	00030603          	lb	a2,0(t1) # ffffa000 <__global_pointer$+0xfffe7710>
 3f4:	0009                	c.nop	2
 3f6:	0100                	addi	s0,sp,128
 3f8:	0306                	slli	t1,t1,0x1
 3fa:	0902                	c.slli64	s2
 3fc:	0004                	0x4
 3fe:	0301                	addi	t1,t1,0
 400:	0901                	addi	s2,s2,0
 402:	0000                	unimp
 404:	0301                	addi	t1,t1,0
 406:	0902                	c.slli64	s2
 408:	0000                	unimp
 40a:	0501                	addi	a0,a0,0
 40c:	0606                	slli	a2,a2,0x1
 40e:	00090003          	lb	zero,0(s2)
 412:	0100                	addi	s0,sp,128
 414:	0505                	addi	a0,a0,1
 416:	0306                	slli	t1,t1,0x1
 418:	0901                	addi	s2,s2,0
 41a:	0004                	0x4
 41c:	0501                	addi	a0,a0,0
 41e:	0900031b          	0x900031b
 422:	0000                	unimp
 424:	0301                	addi	t1,t1,0
 426:	0900                	addi	s0,sp,144
 428:	0000                	unimp
 42a:	0301                	addi	t1,t1,0
 42c:	0900                	addi	s0,sp,144
 42e:	0000                	unimp
 430:	0301                	addi	t1,t1,0
 432:	0900                	addi	s0,sp,144
 434:	0004                	0x4
 436:	0501                	addi	a0,a0,0
 438:	0619                	addi	a2,a2,6
 43a:	00090003          	lb	zero,0(s2)
 43e:	0100                	addi	s0,sp,128
 440:	0305                	addi	t1,t1,1
 442:	0306                	slli	t1,t1,0x1
 444:	0902                	c.slli64	s2
 446:	0004                	0x4
 448:	0501                	addi	a0,a0,0
 44a:	0606                	slli	a2,a2,0x1
 44c:	00090003          	lb	zero,0(s2)
 450:	0100                	addi	s0,sp,128
 452:	0505                	addi	a0,a0,1
 454:	0306                	slli	t1,t1,0x1
 456:	0901                	addi	s2,s2,0
 458:	0004                	0x4
 45a:	0501                	addi	a0,a0,0
 45c:	0311                	addi	t1,t1,4
 45e:	0900                	addi	s0,sp,144
 460:	0000                	unimp
 462:	0301                	addi	t1,t1,0
 464:	0900                	addi	s0,sp,144
 466:	0004                	0x4
 468:	0301                	addi	t1,t1,0
 46a:	0900                	addi	s0,sp,144
 46c:	0004                	0x4
 46e:	0301                	addi	t1,t1,0
 470:	0900                	addi	s0,sp,144
 472:	0004                	0x4
 474:	0501                	addi	a0,a0,0
 476:	060e                	slli	a2,a2,0x3
 478:	00090003          	lb	zero,0(s2)
 47c:	0100                	addi	s0,sp,128
 47e:	0305                	addi	t1,t1,1
 480:	0306                	slli	t1,t1,0x1
 482:	0902                	c.slli64	s2
 484:	0004                	0x4
 486:	0501                	addi	a0,a0,0
 488:	0601                	addi	a2,a2,0
 48a:	00090103          	lb	sp,0(s2)
 48e:	0100                	addi	s0,sp,128
 490:	1409                	addi	s0,s0,-30
 492:	0000                	unimp
 494:	0101                	addi	sp,sp,0

Disassembly of section .debug_frame:

00000000 <.debug_frame>:
   0:	000c                	0xc
   2:	0000                	unimp
   4:	ffff                	0xffff
   6:	ffff                	0xffff
   8:	0001                	nop
   a:	7c01                	lui	s8,0xfffe0
   c:	0d01                	addi	s10,s10,0
   e:	0002                	c.slli64	zero
  10:	0018                	0x18
  12:	0000                	unimp
  14:	0000                	unimp
  16:	0000                	unimp
  18:	0bdc                	addi	a5,sp,468
  1a:	0001                	nop
  1c:	0090                	addi	a2,sp,64
  1e:	0000                	unimp
  20:	0e48                	addi	a0,sp,788
  22:	4c10                	lw	a2,24(s0)
  24:	0181                	addi	gp,gp,0
  26:	6c02                	flw	fs8,0(sp)
  28:	4cc1                	li	s9,16
  2a:	000e                	c.slli	zero,0x3

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
  1e:	69666e6f          	jal	t3,666b4 <__global_pointer$+0x53dc4>
  22:	69722f67          	0x69722f67
  26:	2f766373          	csrrsi	t1,0x2f7,12
  2a:	756d                	lui	a0,0xffffb
  2c:	646c                	flw	fa1,76(s0)
  2e:	3369                	jal	fffffdb8 <__global_pointer$+0xfffed4c8>
  30:	532e                	lw	t1,232(sp)
  32:	2f00                	fld	fs0,24(a4)
  34:	6f68                	flw	fa0,92(a4)
  36:	656d                	lui	a0,0x1b
  38:	796d6a2f          	0x796d6a2f
  3c:	2f65                	jal	7f4 <register_fini-0xf880>
  3e:	6f74                	flw	fa3,92(a4)
  40:	2f736c6f          	jal	s8,36b36 <__global_pointer$+0x24246>
  44:	6972                	flw	fs2,28(sp)
  46:	2d766373          	csrrsi	t1,0x2d7,12
  4a:	2d756e67          	0x2d756e67
  4e:	6f74                	flw	fa3,92(a4)
  50:	68636c6f          	jal	s8,366d6 <__global_pointer$+0x23de6>
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
  9a:	73003233          	0x73003233
  9e:	6f68                	flw	fa0,92(a4)
  a0:	7472                	flw	fs0,60(sp)
  a2:	6920                	flw	fs0,80(a0)
  a4:	746e                	flw	fs0,248(sp)
  a6:	6800                	flw	fs0,16(s0)
  a8:	6174                	flw	fa3,68(a0)
  aa:	5f62                	lw	t5,56(sp)
  ac:	6168                	flw	fa0,68(a0)
  ae:	705f6873          	csrrsi	a6,0x705,30
  b2:	746e696f          	jal	s2,e67f8 <__global_pointer$+0xd3f08>
  b6:	7265                	lui	tp,0xffff9
  b8:	5f00                	lw	s0,56(a4)
  ba:	657a6973          	csrrsi	s2,0x657,20
  be:	5f00                	lw	s0,56(a4)
  c0:	6172                	flw	ft2,28(sp)
  c2:	646e                	flw	fs0,216(sp)
  c4:	3834                	fld	fa3,112(s0)
  c6:	5f00                	lw	s0,56(a4)
  c8:	6d65                	lui	s10,0x19
  ca:	7265                	lui	tp,0xffff9
  cc:	636e6567          	0x636e6567
  d0:	0079                	c.nop	30
  d2:	645f 7961 696c      	0x696c7961645f
  d8:	00746867          	0x746867
  dc:	706d6f63          	bltu	s10,t1,7fa <register_fini-0xf87a>
  e0:	656c                	flw	fa1,76(a0)
  e2:	2078                	fld	fa4,192(s0)
  e4:	6f64                	flw	fs1,92(a4)
  e6:	6275                	lui	tp,0x1d
  e8:	656c                	flw	fa1,76(a0)
  ea:	5f00                	lw	s0,56(a4)
  ec:	64746567          	0x64746567
  f0:	7461                	lui	s0,0xffff8
  f2:	5f65                	li	t5,-7
  f4:	7265                	lui	tp,0xffff9
  f6:	0072                	c.slli	zero,0x1c
  f8:	645f 7461 0061      	0x617461645f
  fe:	775f 7263 6f74      	0x6f747263775f
 104:	626d                	lui	tp,0x1b
 106:	735f 6174 6574      	0x65746174735f
 10c:	7200                	flw	fs0,32(a2)
 10e:	7369                	lui	t1,0xffffa
 110:	6d5f7663          	bgeu	t5,s5,7dc <register_fini-0xf898>
 114:	6369                	lui	t1,0x1a
 116:	6f72                	flw	ft10,28(sp)
 118:	7261                	lui	tp,0xffff8
 11a:	74696863          	bltu	s2,t1,86a <register_fini-0xf80a>
 11e:	6365                	lui	t1,0x19
 120:	7574                	flw	fa3,108(a0)
 122:	6572                	flw	fa0,28(sp)
 124:	745f 7079 0065      	0x657079745f
 12a:	775f 7363 7472      	0x74727363775f
 130:	73626d6f          	jal	s10,26866 <__global_pointer$+0x13f76>
 134:	735f 6174 6574      	0x65746174735f
 13a:	6c00                	flw	fs0,24(s0)
 13c:	20676e6f          	jal	t3,76342 <__global_pointer$+0x63a52>
 140:	6f6c                	flw	fa1,92(a4)
 142:	676e                	flw	fa4,216(sp)
 144:	7520                	flw	fs0,104(a0)
 146:	736e                	flw	ft6,248(sp)
 148:	6769                	lui	a4,0x1a
 14a:	656e                	flw	fa0,216(sp)
 14c:	2064                	fld	fs1,192(s0)
 14e:	6e69                	lui	t3,0x1a
 150:	0074                	addi	a3,sp,12
 152:	69685f77          	0x69685f77
 156:	745f6867          	0x745f6867
 15a:	706d                	c.lui	zero,0xffffb
 15c:	7832                	flw	fa6,44(sp)
 15e:	5f00                	lw	s0,56(a4)
 160:	626c                	flw	fa1,68(a2)
 162:	7366                	flw	ft6,120(sp)
 164:	7a69                	lui	s4,0xffffa
 166:	0065                	c.nop	25
 168:	706d6f63          	bltu	s10,t1,886 <register_fini-0xf7ee>
 16c:	656c                	flw	fa1,76(a0)
 16e:	2078                	fld	fa4,192(s0)
 170:	6f6c                	flw	fa1,92(a4)
 172:	676e                	flw	fa4,216(sp)
 174:	6420                	flw	fs0,72(s0)
 176:	6c62756f          	jal	a0,2783c <__global_pointer$+0x14f4c>
 17a:	0065                	c.nop	25
 17c:	6972                	flw	fs2,28(sp)
 17e:	5f766373          	csrrsi	t1,0x5f7,12
 182:	6261                	lui	tp,0x18
 184:	0069                	c.nop	26
 186:	6e5f 6f69 7362      	0x73626f696e5f
 18c:	5f00                	lw	s0,56(a4)
 18e:	626d                	lui	tp,0x1b
 190:	7472                	flw	fs0,60(sp)
 192:	5f63776f          	jal	a4,37788 <__global_pointer$+0x24e98>
 196:	74617473          	csrrci	s0,0x746,2
 19a:	0065                	c.nop	25
 19c:	745f 6e7a 6d61      	0x6d616e7a745f
 1a2:	0065                	c.nop	25
 1a4:	775f 7463 6d6f      	0x6d6f7463775f
 1aa:	5f62                	lw	t5,56(sp)
 1ac:	74617473          	csrrci	s0,0x746,2
 1b0:	0065                	c.nop	25
 1b2:	5f5f 6d74 735f      	0x735f6d745f5f
 1b8:	6365                	lui	t1,0x19
 1ba:	5f00                	lw	s0,56(a4)
 1bc:	736f6c63          	bltu	t5,s6,8f4 <register_fini-0xf780>
 1c0:	0065                	c.nop	25
 1c2:	5f75                	li	t5,-3
 1c4:	6f6c                	flw	fa1,92(a4)
 1c6:	755f0077          	0x755f0077
 1ca:	7562                	flw	fa0,56(sp)
 1cc:	0066                	c.slli	zero,0x19
 1ce:	69685f77          	0x69685f77
 1d2:	745f6867          	0x745f6867
 1d6:	706d                	c.lui	zero,0xffffb
 1d8:	5f00                	lw	s0,56(a4)
 1da:	6162                	flw	ft2,24(sp)
 1dc:	5f006573          	csrrsi	a0,0x5f0,0
 1e0:	745f 5f6d 6f68      	0x6f685f6d745f
 1e6:	7275                	lui	tp,0xffffd
 1e8:	5f00                	lw	s0,56(a4)
 1ea:	775f 6863 5f00      	0x5f006863775f
 1f0:	735f 0066 6f5f      	0x6f5f0066735f
 1f6:	5f6e                	lw	t5,248(sp)
 1f8:	7865                	lui	a6,0xffff9
 1fa:	7469                	lui	s0,0xffffa
 1fc:	615f 6772 0073      	0x736772615f
 202:	635f 6f6f 696b      	0x696b6f6f635f
 208:	0065                	c.nop	25
 20a:	5f5f 6773 756c      	0x756c67735f5f
 210:	0065                	c.nop	25
 212:	665f 616c 7367      	0x7367616c665f
 218:	5f00                	lw	s0,56(a4)
 21a:	7369                	lui	t1,0xffffa
 21c:	635f 6178 5f00      	0x5f006178635f
 222:	00736477          	0x736477
 226:	5f5f 4946 454c      	0x454c49465f5f
 22c:	5f00                	lw	s0,56(a4)
 22e:	6572                	flw	fa0,28(sp)
 230:	746c7573          	csrrci	a0,0x746,24
 234:	6b5f 5500 4953      	0x495355006b5f
 23a:	7974                	flw	fa3,116(a0)
 23c:	6570                	flw	fa2,76(a0)
 23e:	7200                	flw	fs0,32(a2)
 240:	7369                	lui	t1,0xffffa
 242:	6d5f7663          	bgeu	t5,s5,90e <register_fini-0xf766>
 246:	6369                	lui	t1,0x1a
 248:	6f72                	flw	ft10,28(sp)
 24a:	7261                	lui	tp,0xffff8
 24c:	74696863          	bltu	s2,t1,99c <register_fini-0xf6d8>
 250:	6365                	lui	t1,0x19
 252:	7574                	flw	fa3,108(a0)
 254:	6572                	flw	fa0,28(sp)
 256:	5f00                	lw	s0,56(a4)
 258:	5f737973          	csrrci	s2,0x5f7,6
 25c:	7265                	lui	tp,0xffff9
 25e:	6c72                	flw	fs8,28(sp)
 260:	7369                	lui	t1,0xffffa
 262:	0074                	addi	a3,sp,12
 264:	635f 7476 7562      	0x75627476635f
 26a:	0066                	c.slli	zero,0x19
 26c:	6d5f 7362 7472      	0x747273626d5f
 272:	7363776f          	jal	a4,379a8 <__global_pointer$+0x250b8>
 276:	735f 6174 6574      	0x65746174735f
 27c:	5f00                	lw	s0,56(a4)
 27e:	626d                	lui	tp,0x1b
 280:	6c72                	flw	fs8,28(sp)
 282:	6e65                	lui	t3,0x19
 284:	735f 6174 6574      	0x65746174735f
 28a:	7200                	flw	fs0,32(a2)
 28c:	7369                	lui	t1,0xffffa
 28e:	635f7663          	bgeu	t5,s5,8ba <register_fini-0xf7ba>
 292:	6f6d                	lui	t5,0x1b
 294:	6564                	flw	fs1,76(a0)
 296:	006c                	addi	a1,sp,12
 298:	665f 616e 6772      	0x6772616e665f
 29e:	5f770073          	0x5f770073
 2a2:	6968                	flw	fa0,84(a0)
 2a4:	5f006867          	0x5f006867
 2a8:	6e66                	flw	ft8,88(sp)
 2aa:	735f0073          	0x735f0073
 2ae:	6769                	lui	a4,0x1a
 2b0:	006e                	c.slli	zero,0x1b
 2b2:	735f 6474 7265      	0x72656474735f
 2b8:	0072                	c.slli	zero,0x1c
 2ba:	425f 6769 6e69      	0x6e696769425f
 2c0:	0074                	addi	a3,sp,12
 2c2:	675f 6d61 616d      	0x616d6d61675f
 2c8:	735f 6769 676e      	0x676e6769735f
 2ce:	6d61                	lui	s10,0x18
 2d0:	5f00                	lw	s0,56(a4)
 2d2:	6d6e                	flw	fs10,216(sp)
 2d4:	6c61                	lui	s8,0x18
 2d6:	6f6c                	flw	fa1,92(a4)
 2d8:	5f5f0063          	beq	t5,s5,8b8 <register_fini-0xf7bc>
 2dc:	6d74                	flw	fa3,92(a0)
 2de:	7200                	flw	fs0,32(a2)
 2e0:	7369                	lui	t1,0xffffa
 2e2:	615f7663          	bgeu	t5,s5,8ee <register_fini-0xf786>
 2e6:	6962                	flw	fs2,24(sp)
 2e8:	745f 7079 0065      	0x657079745f
 2ee:	6d5f 7362 6174      	0x617473626d5f
 2f4:	6574                	flw	fa3,76(a0)
 2f6:	5f00                	lw	s0,56(a4)
 2f8:	775f 6863 0062      	0x626863775f
 2fe:	635f 7476 656c      	0x656c7476635f
 304:	006e                	c.slli	zero,0x1b
 306:	665f 6c69 0065      	0x656c69665f
 30c:	6168                	flw	fa0,68(a0)
 30e:	61766873          	csrrsi	a6,0x617,12
 312:	5f6c                	lw	a1,124(a4)
 314:	0074                	addi	a3,sp,12
 316:	5744                	lw	s1,44(a4)
 318:	6e75                	lui	t3,0x1d
 31a:	6f69                	lui	t5,0x1a
 31c:	006e                	c.slli	zero,0x1b
 31e:	656e                	flw	fa0,216(sp)
 320:	5f775f77          	0x5f775f77
 324:	6f6c                	flw	fa1,92(a4)
 326:	2e2e0077          	0x2e2e0077
 32a:	2f2e2e2f          	0x2f2e2e2f
 32e:	2e2e                	fld	ft8,200(sp)
 330:	2f2e2e2f          	0x2f2e2e2f
 334:	6972                	flw	fs2,28(sp)
 336:	2d766373          	csrrsi	t1,0x2d7,12
 33a:	2f636367          	0x2f636367
 33e:	696c                	flw	fa1,84(a0)
 340:	6762                	flw	fa4,24(sp)
 342:	632f6363          	bltu	t5,s2,968 <register_fini-0xf70c>
 346:	69666e6f          	jal	t3,669dc <__global_pointer$+0x540ec>
 34a:	69722f67          	0x69722f67
 34e:	2f766373          	csrrsi	t1,0x2f7,12
 352:	756d                	lui	a0,0xffffb
 354:	746c                	flw	fa1,108(s0)
 356:	3369                	jal	e0 <register_fini-0xff94>
 358:	632e                	flw	ft6,200(sp)
 35a:	7300                	flw	fs0,32(a4)
 35c:	6f68                	flw	fa0,92(a4)
 35e:	7472                	flw	fs0,60(sp)
 360:	7520                	flw	fs0,104(a0)
 362:	736e                	flw	ft6,248(sp)
 364:	6769                	lui	a4,0x1a
 366:	656e                	flw	fa0,216(sp)
 368:	2064                	fld	fs1,192(s0)
 36a:	6e69                	lui	t3,0x1a
 36c:	0074                	addi	a3,sp,12
 36e:	5f5f 6c63 5f7a      	0x5f7a6c635f5f
 374:	6174                	flw	fa3,68(a0)
 376:	0062                	c.slli	zero,0x18
 378:	615f 6574 6978      	0x69786574615f
 37e:	3074                	fld	fa3,224(s0)
 380:	5f00                	lw	s0,56(a4)
 382:	6e676973          	csrrsi	s2,0x6e6,14
 386:	6c61                	lui	s8,0x18
 388:	625f 6675 5f00      	0x5f006675625f
 38e:	7361                	lui	t1,0xffff8
 390:	6d697463          	bgeu	s2,s6,a58 <register_fini-0xf61c>
 394:	5f65                	li	t5,-7
 396:	7562                	flw	fa0,56(sp)
 398:	0066                	c.slli	zero,0x19
 39a:	725f 7365 6c75      	0x6c757365725f
 3a0:	0074                	addi	a3,sp,12
 3a2:	4241                	li	tp,16
 3a4:	5f49                	li	t5,-14
 3a6:	4c49                	li	s8,18
 3a8:	3350                	fld	fa2,160(a4)
 3aa:	4532                	lw	a0,12(sp)
 3ac:	5f00                	lw	s0,56(a4)
 3ae:	656e                	flw	fa0,216(sp)
 3b0:	7478                	flw	fa4,108(s0)
 3b2:	0066                	c.slli	zero,0x19
 3b4:	5f5f 756d 646c      	0x646c756d5f5f
 3ba:	3369                	jal	144 <register_fini-0xff30>
 3bc:	6500                	flw	fs0,8(a0)
 3be:	766e                	flw	fa2,248(sp)
 3c0:	7269                	lui	tp,0xffffa
 3c2:	77006e6f          	jal	t3,6b32 <register_fini-0x9542>
 3c6:	6e69                	lui	t3,0x1a
 3c8:	5f74                	lw	a3,124(a4)
 3ca:	0074                	addi	a3,sp,12
 3cc:	6c5f 636f 006b      	0x6b636f6c5f
 3d2:	4241                	li	tp,16
 3d4:	5f49                	li	t5,-14
 3d6:	4c49                	li	s8,18
 3d8:	3350                	fld	fa2,160(a4)
 3da:	4432                	lw	s0,12(sp)
 3dc:	5f00                	lw	s0,56(a4)
 3de:	756d                	lui	a0,0xffffb
 3e0:	746c                	flw	fa1,108(s0)
 3e2:	4400                	lw	s0,8(s0)
 3e4:	7449                	lui	s0,0xffff2
 3e6:	7079                	c.lui	zero,0xffffe
 3e8:	0065                	c.nop	25
 3ea:	5f5f 6f6c 6163      	0x61636f6c5f5f
 3f0:	656c                	flw	fa1,76(a0)
 3f2:	745f 7500 736e      	0x736e7500745f
 3f8:	6570                	flw	fa2,76(a0)
 3fa:	74735f63          	bge	t1,t2,b58 <register_fini-0xf51c>
 3fe:	6972                	flw	fs2,28(sp)
 400:	676e                	flw	fa4,216(sp)
 402:	5f5f0073          	0x5f5f0073
 406:	0030706f          	j	7c08 <register_fini-0x846c>
 40a:	5f5f 706f 0031      	0x31706f5f5f
 410:	7274706f          	j	48336 <__global_pointer$+0x35a46>
 414:	7365                	lui	t1,0xffff9
 416:	7465                	lui	s0,0xffff9
 418:	5f00                	lw	s0,56(a4)
 41a:	74697277          	0x74697277
 41e:	0065                	c.nop	25
 420:	5f5f 6d74 795f      	0x795f6d745f5f
 426:	6165                	addi	sp,sp,112
 428:	0072                	c.slli	zero,0x1c
 42a:	4241                	li	tp,16
 42c:	5f49                	li	t5,-14
 42e:	4c49                	li	s8,18
 430:	3350                	fld	fa2,160(a4)
 432:	4632                	lw	a2,12(sp)
 434:	5f00                	lw	s0,56(a4)
 436:	6e75                	lui	t3,0x1d
 438:	7375                	lui	t1,0xffffd
 43a:	6465                	lui	s0,0x19
 43c:	725f 6e61 0064      	0x646e61725f
 442:	6972                	flw	fs2,28(sp)
 444:	5f766373          	csrrsi	t1,0x5f7,12
 448:	65646f63          	bltu	s0,s6,aa6 <register_fini-0xf5ce>
 44c:	6d5f 646f 6c65      	0x6c65646f6d5f
 452:	5f00                	lw	s0,56(a4)
 454:	7366666f          	jal	a2,66b8a <__global_pointer$+0x5429a>
 458:	7465                	lui	s0,0xffff9
 45a:	6f00                	flw	fs0,24(a4)
 45c:	7470                	flw	fa2,108(s0)
 45e:	6e69                	lui	t3,0x1a
 460:	0064                	addi	s1,sp,12
 462:	706d6f63          	bltu	s10,t1,b80 <register_fini-0xf4f4>
 466:	656c                	flw	fa1,76(a0)
 468:	2078                	fld	fa4,192(s0)
 46a:	6c66                	flw	fs8,88(sp)
 46c:	0074616f          	jal	sp,46c72 <__global_pointer$+0x34382>
 470:	6f6c                	flw	fa1,92(a4)
 472:	676e                	flw	fa4,216(sp)
 474:	6c20                	flw	fs0,88(s0)
 476:	20676e6f          	jal	t3,7667c <__global_pointer$+0x63d8c>
 47a:	6e69                	lui	t3,0x1a
 47c:	0074                	addi	a3,sp,12
 47e:	5f5f 6d74 6d5f      	0x6d5f6d745f5f
 484:	5f006e6f          	jal	t3,6a74 <register_fini-0x9600>
 488:	7461                	lui	s0,0xffff8
 48a:	7865                	lui	a6,0xffff9
 48c:	7469                	lui	s0,0xffffa
 48e:	7300                	flw	fs0,32(a4)
 490:	6275                	lui	tp,0x1d
 492:	6174706f          	j	482a8 <__global_pointer$+0x359b8>
 496:	6772                	flw	fa4,28(sp)
 498:	5f00                	lw	s0,56(a4)
 49a:	735f 6964 6964      	0x69646964735f
 4a0:	696e                	flw	fs2,216(sp)
 4a2:	0074                	addi	a3,sp,12
 4a4:	6f5f 6666 745f      	0x745f66666f5f
 4aa:	4400                	lw	s0,8(s0)
 4ac:	72747357          	0x72747357
 4b0:	6375                	lui	t1,0x1d
 4b2:	0074                	addi	a3,sp,12
 4b4:	665f 6572 6c65      	0x6c656572665f
 4ba:	7369                	lui	t1,0xffffa
 4bc:	0074                	addi	a3,sp,12
 4be:	745f 6d69 7a65      	0x7a656d69745f
 4c4:	00656e6f          	jal	t3,564ca <__global_pointer$+0x43bda>
 4c8:	6d5f 7362 6174      	0x617473626d5f
 4ce:	6574                	flw	fa3,76(a0)
 4d0:	745f 5f00 4f4c      	0x4f4c5f00745f
 4d6:	525f4b43          	fmadd.d	fs6,ft10,ft5,fa0,rmm
 4da:	4345                	li	t1,17
 4dc:	5255                	li	tp,-11
 4de:	45564953          	0x45564953
 4e2:	545f 5f00 6572      	0x65725f00545f
 4e8:	6461                	lui	s0,0x18
 4ea:	6300                	flw	fs0,0(a4)
 4ec:	7261                	lui	tp,0xffff8
 4ee:	7972                	flw	fs2,60(sp)
 4f0:	4100                	lw	s0,0(a0)
 4f2:	4942                	lw	s2,16(sp)
 4f4:	4c5f 3650 0034      	0x3436504c5f
 4fa:	4241                	li	tp,16
 4fc:	5f49                	li	t5,-14
 4fe:	4c49                	li	s8,18
 500:	3350                	fld	fa2,160(a4)
 502:	0032                	c.slli	zero,0xc
 504:	645f 6f73 685f      	0x685f6f73645f
 50a:	6e61                	lui	t3,0x18
 50c:	6c64                	flw	fs1,92(s0)
 50e:	0065                	c.nop	25
 510:	4d5f4d43          	0x4d5f4d43
 514:	4445                	li	s0,17
 516:	4e41                	li	t3,16
 518:	0059                	c.nop	22
 51a:	6e5f 7765 5f00      	0x5f0077656e5f
 520:	5f68                	lw	a0,124(a4)
 522:	7265                	lui	tp,0xffff9
 524:	6e72                	flw	ft8,28(sp)
 526:	665f006f          	j	f138a <__global_pointer$+0xdea9a>
 52a:	6f6c                	flw	fa1,92(a4)
 52c:	745f6b63          	bltu	t5,t0,c82 <register_fini-0xf3f2>
 530:	5f00                	lw	s0,56(a4)
 532:	735f 7562 0066      	0x667562735f
 538:	665f 616c 7367      	0x7367616c665f
 53e:	0032                	c.slli	zero,0xc
 540:	695f 626f 0073      	0x73626f695f
 546:	4d5f4d43          	0x4d5f4d43
 54a:	4445                	li	s0,17
 54c:	4f4c                	lw	a1,28(a4)
 54e:	74680057          	0x74680057
 552:	6261                	lui	tp,0x18
 554:	685f 7361 0068      	0x687361685f
 55a:	5f5f 4673 4c49      	0x4c4946735f5f
 560:	0045                	c.nop	17
 562:	735f 7379 6e5f      	0x6e5f7379735f
 568:	7265                	lui	tp,0xffff9
 56a:	0072                	c.slli	zero,0x1c
 56c:	725f 6e61 5f64      	0x5f646e61725f
 572:	656e                	flw	fa0,216(sp)
 574:	7478                	flw	fa4,108(s0)
 576:	7500                	flw	fs0,40(a0)
 578:	6c5f 776f 6d5f      	0x6d5f776f6c5f
 57e:	47006273          	csrrsi	tp,0x470,0
 582:	554e                	lw	a0,240(sp)
 584:	4320                	lw	s0,64(a4)
 586:	3731                	jal	492 <register_fini-0xfbe2>
 588:	3920                	fld	fs0,112(a0)
 58a:	322e                	fld	ft4,232(sp)
 58c:	302e                	fld	ft0,232(sp)
 58e:	2d20                	fld	fs0,88(a0)
 590:	636d                	lui	t1,0x1b
 592:	6f6d                	lui	t5,0x1b
 594:	6564                	flw	fs1,76(a0)
 596:	3d6c                	fld	fa1,248(a0)
 598:	656d                	lui	a0,0x1b
 59a:	6c64                	flw	fs1,92(s0)
 59c:	2d20776f          	jal	a4,786e <register_fini-0x8806>
 5a0:	636d                	lui	t1,0x1b
 5a2:	6f6d                	lui	t5,0x1b
 5a4:	6564                	flw	fs1,76(a0)
 5a6:	3d6c                	fld	fa1,248(a0)
 5a8:	656d                	lui	a0,0x1b
 5aa:	6c64                	flw	fs1,92(s0)
 5ac:	2d20776f          	jal	a4,787e <register_fini-0x87f6>
 5b0:	746d                	lui	s0,0xffffb
 5b2:	6e75                	lui	t3,0x1d
 5b4:	3d65                	jal	46c <register_fini-0xfc08>
 5b6:	6f72                	flw	ft10,28(sp)
 5b8:	74656b63          	bltu	a0,t1,d0e <register_fini-0xf366>
 5bc:	2d20                	fld	fs0,88(a0)
 5be:	616d                	addi	sp,sp,240
 5c0:	6372                	flw	ft6,28(sp)
 5c2:	3d68                	fld	fa0,248(a0)
 5c4:	7672                	flw	fa2,60(sp)
 5c6:	20693233          	0x20693233
 5ca:	6d2d                	lui	s10,0xb
 5cc:	6261                	lui	tp,0x18
 5ce:	3d69                	jal	468 <register_fini-0xfc0c>
 5d0:	6c69                	lui	s8,0x1a
 5d2:	3370                	fld	fa2,224(a4)
 5d4:	2032                	fld	ft0,264(sp)
 5d6:	672d                	lui	a4,0xb
 5d8:	2d20                	fld	fs0,88(a0)
 5da:	2d20734f          	0x2d20734f
 5de:	2d20324f          	0x2d20324f
 5e2:	2d20734f          	0x2d20734f
 5e6:	6266                	flw	ft4,88(sp)
 5e8:	6975                	lui	s2,0x1d
 5ea:	646c                	flw	fa1,76(s0)
 5ec:	6e69                	lui	t3,0x1a
 5ee:	696c2d67          	0x696c2d67
 5f2:	6762                	flw	fa4,24(sp)
 5f4:	2d206363          	bltu	zero,s2,8ba <register_fini-0xf7ba>
 5f8:	6e66                	flw	ft8,88(sp)
 5fa:	74732d6f          	jal	s10,33540 <__global_pointer$+0x20c50>
 5fe:	6361                	lui	t1,0x18
 600:	72702d6b          	0x72702d6b
 604:	6365746f          	jal	s0,57c3a <__global_pointer$+0x4534a>
 608:	6f74                	flw	fa3,92(a4)
 60a:	2072                	fld	ft0,280(sp)
 60c:	662d                	lui	a2,0xb
 60e:	6976                	flw	fs2,92(sp)
 610:	69626973          	csrrsi	s2,0x696,4
 614:	696c                	flw	fa1,84(a0)
 616:	7974                	flw	fa3,116(a0)
 618:	683d                	lui	a6,0xf
 61a:	6469                	lui	s0,0x1a
 61c:	6564                	flw	fs1,76(a0)
 61e:	006e                	c.slli	zero,0x1b
 620:	6d5f 6c62 6e65      	0x6e656c626d5f
 626:	735f 6174 6574      	0x65746174735f
 62c:	5f00                	lw	s0,56(a4)
 62e:	6e69                	lui	t3,0x1a
 630:	695f0063          	beq	t5,s5,cb0 <register_fini-0xf3c4>
 634:	646e                	flw	fs0,216(sp)
 636:	5f00                	lw	s0,56(a4)
 638:	635f 656c 6e61      	0x6e61656c635f
 63e:	7075                	c.lui	zero,0xffffd
 640:	5f00                	lw	s0,56(a4)
 642:	6e75                	lui	t3,0x1d
 644:	63657073          	csrci	0x636,10
 648:	6669                	lui	a2,0x1a
 64a:	6569                	lui	a0,0x1a
 64c:	5f64                	lw	s1,124(a4)
 64e:	6f6c                	flw	fa1,92(a4)
 650:	656c6163          	bltu	s8,s6,c92 <register_fini-0xf3e2>
 654:	695f 666e 006f      	0x6f666e695f
 65a:	6d5f 7861 6477      	0x647778616d5f
 660:	725f0073          	0x725f0073
 664:	6565                	lui	a0,0x19
 666:	746e                	flw	fs0,248(sp)
 668:	5f00                	lw	s0,56(a4)
 66a:	64656573          	csrrsi	a0,0x646,10
 66e:	5f00                	lw	s0,56(a4)
 670:	635f 756f 746e      	0x746e756f635f
 676:	5f00                	lw	s0,56(a4)
 678:	765f 6c61 6575      	0x65756c61765f
 67e:	5f00                	lw	s0,56(a4)
 680:	6b656573          	csrrsi	a0,0x6b6,10
 684:	5f00                	lw	s0,56(a4)
 686:	7066                	flw	ft0,120(sp)
 688:	745f736f          	jal	t1,f85cc <__global_pointer$+0xe5cdc>
 68c:	7300                	flw	fs0,32(a4)
 68e:	6669                	lui	a2,0x1a
 690:	7669                	lui	a2,0xffffa
 692:	5f65                	li	t5,-7
 694:	625f0037          	lui	zero,0x625f0
 698:	6b6c                	flw	fa1,84(a4)
 69a:	657a6973          	csrrsi	s2,0x657,20
 69e:	6700                	flw	fs0,8(a4)
 6a0:	6e65                	lui	t3,0x19
 6a2:	7265                	lui	tp,0xffff9
 6a4:	6369                	lui	t1,0x1a
 6a6:	7600                	flw	fs0,40(a2)
 6a8:	6c5f 776f 7500      	0x7500776f6c5f
 6ae:	736e                	flw	ft6,248(sp)
 6b0:	6570                	flw	fa2,76(a0)
 6b2:	735f7663          	bgeu	t5,s5,dde <register_fini-0xf296>
 6b6:	7274                	flw	fa3,100(a2)
 6b8:	6e69                	lui	t3,0x1a
 6ba:	6f007367          	0x6f007367
 6be:	7470                	flw	fa2,108(s0)
 6c0:	7265                	lui	tp,0xffff9
 6c2:	0072                	c.slli	zero,0x1c
 6c4:	735f 7274 6f74      	0x6f747274735f
 6ca:	616c5f6b          	0x616c5f6b
 6ce:	43007473          	csrrci	s0,0x430,0
 6d2:	5f4d                	li	t5,-13
 6d4:	4950                	lw	a2,20(a0)
 6d6:	665f0043          	fmadd.q	ft0,ft10,ft5,fa2,rne
 6da:	746e                	flw	fs0,248(sp)
 6dc:	7079                	c.lui	zero,0xffffe
 6de:	7365                	lui	t1,0xffff9
 6e0:	7500                	flw	fs0,40(a0)
 6e2:	736e                	flw	ft6,248(sp)
 6e4:	6769                	lui	a4,0x1a
 6e6:	656e                	flw	fa0,216(sp)
 6e8:	2064                	fld	fs1,192(s0)
 6ea:	72616863          	bltu	sp,t1,e1a <register_fini-0xf25a>
 6ee:	5f00                	lw	s0,56(a4)
 6f0:	6461                	lui	s0,0x18
 6f2:	0064                	addi	s1,sp,12
 6f4:	5f5f 4c55 6e6f      	0x6e6f4c555f5f
 6fa:	74680067          	jr	1862(a6) # f746 <register_fini-0x92e>
 6fe:	6261                	lui	tp,0x18
 700:	655f 5f71 6f70      	0x6f705f71655f
 706:	6e69                	lui	t3,0x1a
 708:	6574                	flw	fa3,76(a0)
 70a:	0072                	c.slli	zero,0x1c
 70c:	675f 6f6c 6162      	0x61626f6c675f
 712:	5f6c                	lw	a1,124(a4)
 714:	6d69                	lui	s10,0x1a
 716:	7570                	flw	fa2,108(a0)
 718:	6572                	flw	fa0,28(sp)
 71a:	705f 7274 5f00      	0x5f007274705f
 720:	6f647473          	csrrci	s0,0x6f6,8
 724:	7475                	lui	s0,0xffffd
 726:	5f00                	lw	s0,56(a4)
 728:	745f 5f6d 6477      	0x64775f6d745f
 72e:	7961                	lui	s2,0xffff8
 730:	5f00                	lw	s0,56(a4)
 732:	65756c67          	0x65756c67
 736:	5f00                	lw	s0,56(a4)
 738:	69647473          	csrrci	s0,0x696,8
 73c:	006e                	c.slli	zero,0x1b
 73e:	735f 6973 657a      	0x657a6973735f
 744:	745f 5f00 366c      	0x366c5f00745f
 74a:	6134                	flw	fa3,64(a0)
 74c:	625f 6675 5f00      	0x5f006675625f
 752:	5f676973          	csrrsi	s2,0x5f6,14
 756:	7566                	flw	fa0,120(sp)
 758:	636e                	flw	ft6,216(sp)
 75a:	5f00                	lw	s0,56(a4)
 75c:	705f 706f 6f63      	0x6f63706f705f
 762:	6e75                	lui	t3,0x1d
 764:	5f74                	lw	a3,124(a4)
 766:	6174                	flw	fa3,68(a0)
 768:	0062                	c.slli	zero,0x18
 76a:	6e5f 7562 0066      	0x6675626e5f
 770:	755f 756e 6573      	0x6573756e755f
 776:	0064                	addi	s1,sp,12
 778:	5f5f 6d74 695f      	0x695f6d745f5f
 77e:	74736473          	csrrsi	s0,0x747,6
 782:	5f00                	lw	s0,56(a4)
 784:	6f6c                	flw	fa1,92(a4)
 786:	746c6163          	bltu	s8,t1,ec8 <register_fini-0xf1ac>
 78a:	6d69                	lui	s10,0x1a
 78c:	5f65                	li	t5,-7
 78e:	7562                	flw	fa0,56(sp)
 790:	0066                	c.slli	zero,0x19
 792:	5f5f 6d74 6d5f      	0x6d5f6d745f5f
 798:	6e69                	lui	t3,0x1a
 79a:	5f00                	lw	s0,56(a4)
 79c:	3472                	fld	fs0,312(sp)
 79e:	0038                	addi	a4,sp,8
 7a0:	4241                	li	tp,16
 7a2:	5f49                	li	t5,-14
 7a4:	504c                	lw	a1,36(s0)
 7a6:	3436                	fld	fs0,360(sp)
 7a8:	0044                	addi	s1,sp,4
 7aa:	6f74706f          	j	486a0 <__global_pointer$+0x35db0>
 7ae:	7470                	flw	fa2,108(s0)
 7b0:	4100                	lw	s0,0(a0)
 7b2:	4942                	lw	s2,16(sp)
 7b4:	4c5f 3650 4634      	0x463436504c5f
 7ba:	5f00                	lw	s0,56(a4)
 7bc:	626d                	lui	tp,0x1b
 7be:	6f74                	flw	fa3,92(a4)
 7c0:	735f6377          	0x735f6377
 7c4:	6174                	flw	fa3,68(a0)
 7c6:	6574                	flw	fa3,76(a0)
 7c8:	5f00                	lw	s0,56(a4)
 7ca:	3570                	fld	fa2,232(a0)
 7cc:	5f5f0073          	0x5f5f0073
 7d0:	6d74                	flw	fa3,92(a0)
 7d2:	795f 6164 0079      	0x796164795f
 7d8:	6c5f 636f 6c61      	0x6c61636f6c5f
 7de:	0065                	c.nop	25
 7e0:	5155                	li	sp,-11
 7e2:	7449                	lui	s0,0xffff2
 7e4:	7079                	c.lui	zero,0xffffe
 7e6:	0065                	c.nop	25
 7e8:	5f5f 6d74 6d5f      	0x6d5f6d745f5f
 7ee:	6164                	flw	fs1,68(a0)
 7f0:	0079                	c.nop	30
 7f2:	7468                	flw	fa0,108(s0)
 7f4:	6261                	lui	tp,0x18
 7f6:	655f 0071       	0x71655f

Disassembly of section .debug_loc:

00000000 <.debug_loc>:
   0:	0000                	unimp
   2:	0000                	unimp
   4:	000c                	0xc
   6:	0000                	unimp
   8:	0006                	c.slli	zero,0x1
   a:	935a                	add	t1,t1,s6
   c:	5b04                	lw	s1,48(a4)
   e:	000c0493          	mv	s1,s8
  12:	0000                	unimp
  14:	0090                	addi	a2,sp,64
  16:	0000                	unimp
  18:	0006                	c.slli	zero,0x1
  1a:	0af503f3          	0xaf503f3
  1e:	9f25                	0x9f25
	...
  2c:	0018                	0x18
  2e:	0000                	unimp
  30:	0006                	c.slli	zero,0x1
  32:	935c                	0x935c
  34:	5d04                	lw	s1,56(a0)
  36:	00180493          	addi	s1,a6,1
  3a:	0000                	unimp
  3c:	0090                	addi	a2,sp,64
  3e:	0000                	unimp
  40:	0006                	c.slli	zero,0x1
  42:	0cf503f3          	0xcf503f3
  46:	9f25                	0x9f25
	...
  50:	0018                	0x18
  52:	0000                	unimp
  54:	0028                	addi	a0,sp,8
  56:	0000                	unimp
  58:	0001                	nop
  5a:	2856                	fld	fa6,336(sp)
  5c:	0000                	unimp
  5e:	5800                	lw	s0,48(s0)
  60:	0000                	unimp
  62:	0100                	addi	s0,sp,128
  64:	5c00                	lw	s0,56(s0)
	...
  6e:	0018                	0x18
  70:	0000                	unimp
  72:	0028                	addi	a0,sp,8
  74:	0000                	unimp
  76:	0001                	nop
  78:	285a                	fld	fa6,400(sp)
  7a:	0000                	unimp
  7c:	6400                	flw	fs0,8(s0)
  7e:	0000                	unimp
  80:	0100                	addi	s0,sp,128
  82:	5d00                	lw	s0,56(a0)
	...
  8c:	0018                	0x18
  8e:	0000                	unimp
  90:	0028                	addi	a0,sp,8
  92:	0000                	unimp
  94:	0002                	c.slli64	zero
  96:	9f30                	0x9f30
  98:	0028                	addi	a0,sp,8
  9a:	0000                	unimp
  9c:	0038                	addi	a4,sp,8
  9e:	0000                	unimp
  a0:	0001                	nop
  a2:	3860                	fld	fs0,240(s0)
  a4:	0000                	unimp
  a6:	4800                	lw	s0,16(s0)
  a8:	0000                	unimp
  aa:	0100                	addi	s0,sp,128
  ac:	6c00                	flw	fs0,24(s0)
  ae:	0048                	addi	a0,sp,4
  b0:	0000                	unimp
  b2:	0090                	addi	a2,sp,64
  b4:	0000                	unimp
  b6:	0001                	nop
  b8:	0060                	addi	s0,sp,12
  ba:	0000                	unimp
  bc:	0000                	unimp
  be:	0000                	unimp
  c0:	2800                	fld	fs0,16(s0)
  c2:	0000                	unimp
  c4:	3800                	fld	fs0,48(s0)
  c6:	0000                	unimp
  c8:	0600                	addi	s0,sp,768
  ca:	7c00                	flw	fs0,56(s0)
  cc:	8000                	0x8000
  ce:	2200                	fld	fs0,0(a2)
  d0:	389f 0000 4800      	0x48000000389f
  d6:	0000                	unimp
  d8:	0100                	addi	s0,sp,128
  da:	6c00                	flw	fs0,24(s0)
	...
  e4:	0018                	0x18
  e6:	0000                	unimp
  e8:	0028                	addi	a0,sp,8
  ea:	0000                	unimp
  ec:	0002                	c.slli64	zero
  ee:	9f30                	0x9f30
  f0:	0028                	addi	a0,sp,8
  f2:	0000                	unimp
  f4:	0040                	addi	s0,sp,4
  f6:	0000                	unimp
  f8:	0001                	nop
  fa:	445f 0000 6800      	0x68000000445f
 100:	0000                	unimp
 102:	0100                	addi	s0,sp,128
 104:	5f00                	lw	s0,56(a4)
	...
 10e:	0018                	0x18
 110:	0000                	unimp
 112:	0028                	addi	a0,sp,8
 114:	0000                	unimp
 116:	0002                	c.slli64	zero
 118:	9f30                	0x9f30
 11a:	0028                	addi	a0,sp,8
 11c:	0000                	unimp
 11e:	0030                	addi	a2,sp,8
 120:	0000                	unimp
 122:	0001                	nop
 124:	305e                	fld	ft0,496(sp)
 126:	0000                	unimp
 128:	4000                	lw	s0,0(s0)
 12a:	0000                	unimp
 12c:	0600                	addi	s0,sp,768
 12e:	7f00                	flw	fs0,56(a4)
 130:	7e00                	flw	fs0,56(a2)
 132:	2200                	fld	fs0,0(a2)
 134:	409f 0000 4400      	0x44000000409f
 13a:	0000                	unimp
 13c:	0100                	addi	s0,sp,128
 13e:	5f00                	lw	s0,56(a4)
 140:	0058                	addi	a4,sp,4
 142:	0000                	unimp
 144:	0090                	addi	a2,sp,64
 146:	0000                	unimp
 148:	0001                	nop
 14a:	005e                	c.slli	zero,0x17
 14c:	0000                	unimp
 14e:	0000                	unimp
 150:	0000                	unimp
 152:	3800                	fld	fs0,48(s0)
 154:	0000                	unimp
 156:	3c00                	fld	fs0,56(s0)
 158:	0000                	unimp
 15a:	1100                	addi	s0,sp,160
 15c:	8000                	0x8000
 15e:	4000                	lw	s0,0(s0)
 160:	8c22244b          	0x8c22244b
 164:	4000                	lw	s0,0(s0)
 166:	2b22244b          	fnmsub.d	fs0,ft4,fs2,ft5,rdn
 16a:	ff08                	fsw	fa0,56(a4)
 16c:	9f1a                	add	t5,t5,t1
	...
