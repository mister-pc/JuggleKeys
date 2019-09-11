;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Tray menu :
;;;;;;;;;;;;;

TRY_InitMenus() {

	Global
	AHK_Log("> TRY_InitMenus()")

	; Locutions :
	;;;;;;;;;;;;;

	Menu, Locutions, Add, ms`tmais, TRY_TrayMenuHotstring
	Menu, Locutions, Add, cpdt`tcependant, TRY_TrayMenuHotstring
	Menu, Locutions, Add, dail`td'ailleurs, TRY_TrayMenuHotstring
	Menu, Locutions, Add, parail`tpar ailleurs, TRY_TrayMenuHotstring
	Menu, Locutions, Add, ps`tpuis, TRY_TrayMenuHotstring
	Menu, Locutions, Add, dlmo`tdans la mesure où, TRY_TrayMenuHotstring
	Menu, Locutions, Add, dc`tdonc, TRY_TrayMenuHotstring
	Menu, Locutions, Add, cad`tc'est-à-dire, TRY_TrayMenuHotstring
	Menu, Locutions, Add
	Menu, Locutions, Add, ya`til y a, TRY_TrayMenuHotstring
	Menu, Locutions, Add, yav`til y avait, TRY_TrayMenuHotstring
	Menu, Locutions, Add, nya`til n'y a, TRY_TrayMenuHotstring
	Menu, Locutions, Add, nyav`til n'y avait, TRY_TrayMenuHotstring
	Menu, Locutions, Add, yena`til y en a, TRY_TrayMenuHotstring
	Menu, Locutions, Add, yenav`til y en avait, TRY_TrayMenuHotstring

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	; Subordonates :
	;;;;;;;;;;;;;;;;

	Menu, Subordonates, Add, q`tque, TRY_TrayMenuHotstring
	Menu, Subordonates, Add, bq`tbien que, TRY_TrayMenuHotstring
	Menu, Subordonates, Add, tq`ttant que, TRY_TrayMenuHotstring
	Menu, Subordonates, Add, tdq`ttandis que, TRY_TrayMenuHotstring
	Menu, Subordonates, Add, avq`tavant que, TRY_TrayMenuHotstring
	Menu, Subordonates, Add, dpq`tdepuis que, TRY_TrayMenuHotstring
	Menu, Subordonates, Add, dq`tdès que, TRY_TrayMenuHotstring
	Menu, Subordonates, Add, asq`tainsi que, TRY_TrayMenuHotstring
	Menu, Subordonates, Add, alq`talors que, TRY_TrayMenuHotstring
	Menu, Subordonates, Add, dlq`tdès lors que, TRY_TrayMenuHotstring
	Menu, Subordonates, Add, pdq`tpendant que, TRY_TrayMenuHotstring
	Menu, Subordonates, Add, apq`taprès que, TRY_TrayMenuHotstring
	Menu, Subordonates, Add, jqcq`tjusqu'à ce que, TRY_TrayMenuHotstring
	Menu, Subordonates, Add, lq`tlorsque, TRY_TrayMenuHotstring
	Menu, Subordonates, Add, qd`tquand, TRY_TrayMenuHotstring
	Menu, Subordonates, Add
	Menu, Subordonates, Add, cmt`tcomment, TRY_TrayMenuHotstring
	Menu, Subordonates, Add, cb`tcombien, TRY_TrayMenuHotstring
	Menu, Subordonates, Add, pq`tpourquoi, TRY_TrayMenuHotstring
	Menu, Subordonates, Add, pcq`tparce que, TRY_TrayMenuHotstring
	Menu, Subordonates, Add, psq`tpuisque, TRY_TrayMenuHotstring
	Menu, Subordonates, Add, afq`tafin que, TRY_TrayMenuHotstring
	Menu, Subordonates, Add, slq`tselon que, TRY_TrayMenuHotstring
	Menu, Subordonates, Add, mgq`tmalgré que, TRY_TrayMenuHotstring
	Menu, Subordonates, Add, sfq`tsauf que, TRY_TrayMenuHotstring
	Menu, Subordonates, Add, prq`tpour que, TRY_TrayMenuHotstring
	Menu, Subordonates, Add, ssq`tsans que, TRY_TrayMenuHotstring

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	; Verbs :
	;;;;;;;;;

	Menu, Verbs, Add, cé`tc'est, TRY_TrayMenuHotstring
	Menu, Verbs, Add, ct`tc'était, TRY_TrayMenuHotstring
	Menu, Verbs, Add, mé`tm'est, TRY_TrayMenuHotstring
	Menu, Verbs, Add, né`tn'est, TRY_TrayMenuHotstring
	Menu, Verbs, Add, mt`tm'étai, TRY_TrayMenuHotstring
	Menu, Verbs, Add, nt`tn'étai, TRY_TrayMenuHotstring
	Menu, Verbs, Add, sé`ts'est, TRY_TrayMenuHotstring
	Menu, Verbs, Add, qsq`tqu'est-ce que, TRY_TrayMenuHotstring
	Menu, Verbs, Add, sq`test-ce que, TRY_TrayMenuHotstring
	Menu, Verbs, Add, ayé`tça y est, TRY_TrayMenuHotstring
	Menu, Verbs, Add, ê`têtre, TRY_TrayMenuHotstring
	Menu, Verbs, Add, jé`tj'ai, TRY_TrayMenuHotstring
	Menu, Verbs, Add, jné`tje n'ai, TRY_TrayMenuHotstring
	Menu, Verbs, Add, jém`tj'aime, TRY_TrayMenuHotstring
	Menu, Verbs, Add, té`tt'ai, TRY_TrayMenuHotstring
	Menu, Verbs, Add, jnté`tje ne t'ai, TRY_TrayMenuHotstring
	Menu, Verbs, Add, gt`tj'étais, TRY_TrayMenuHotstring
	Menu, Verbs, Add, jv && gv`tj'avais, TRY_TrayMenuHotstring
	Menu, Verbs, Add
	Menu, Verbs, Add, fr`tfaire, TRY_TrayMenuHotstring
	Menu, Verbs, Add, fé`tfait, TRY_TrayMenuHotstring
	Menu, Verbs, Add, fo`tfaut, TRY_TrayMenuHotstring
	Menu, Verbs, Add, ft`tfont, TRY_TrayMenuHotstring
	Menu, Verbs, Add, st`tsont, TRY_TrayMenuHotstring
	Menu, Verbs, Add, vx`tveux, TRY_TrayMenuHotstring
	Menu, Verbs, Add, ve`tveut, TRY_TrayMenuHotstring
	Menu, Verbs, Add, vd`tvend, TRY_TrayMenuHotstring
	Menu, Verbs, Add, vo`tvaut, TRY_TrayMenuHotstring
	Menu, Verbs, Add, vt`tvont, TRY_TrayMenuHotstring
	Menu, Verbs, Add, cmc`tcommence, TRY_TrayMenuHotstring
	Menu, Verbs, Add, dvlp`tdéveloppe, TRY_TrayMenuHotstring
	Menu, Verbs, Add, mq`tmanqu, TRY_TrayMenuHotstring
	Menu, Verbs, Add, djn`tdéjeun, TRY_TrayMenuHotstring
	Menu, Verbs, Add, spr`tespère, TRY_TrayMenuHotstring
	Menu, Verbs, Add, jspr`tj'espère, TRY_TrayMenuHotstring
	Menu, Verbs, Add, apl`tappel, TRY_TrayMenuHotstring
	Menu, Verbs, Add, prd`tprend, TRY_TrayMenuHotstring
	Menu, Verbs, Add, cprd`tcomprend, TRY_TrayMenuHotstring
	Menu, Verbs, Add, dpd`tdépend, TRY_TrayMenuHotstring
	Menu, Verbs, Add
	Menu, Verbs, Add, px`tpeux, TRY_TrayMenuHotstring
	Menu, Verbs, Add, pt`tpeut, TRY_TrayMenuHotstring
	Menu, Verbs, Add, pvai`tpouvai, TRY_TrayMenuHotstring
	Menu, Verbs, Add, pvons`tpouvons, TRY_TrayMenuHotstring
	Menu, Verbs, Add, pvez`tpouvez, TRY_TrayMenuHotstring
	Menu, Verbs, Add, pvt`tpeuvent, TRY_TrayMenuHotstring
	Menu, Verbs, Add, vlt`tveulent, TRY_TrayMenuHotstring

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	; Adverbs :
	;;;;;;;;;;;

	Menu, Adverbs, Add, dab`td'abord, TRY_TrayMenuHotstring
	Menu, Adverbs, Add, mm`tmême, TRY_TrayMenuHotstring
	Menu, Adverbs, Add, +to`tplutôt, TRY_TrayMenuHotstring
	Menu, Adverbs, Add, ++`tplus, TRY_TrayMenuHotstring
	Menu, Adverbs, Add, +ou-`tplus ou moins, TRY_TrayMenuHotstring
	Menu, Adverbs, Add, --`tmoins, TRY_TrayMenuHotstring
	Menu, Adverbs, Add, àpp`tà peu près, TRY_TrayMenuHotstring
	Menu, Adverbs, Add, prsq`tpresque, TRY_TrayMenuHotstring
	Menu, Adverbs, Add, ac`tassez, TRY_TrayMenuHotstring
	Menu, Adverbs, Add, surtt`tsurtout, TRY_TrayMenuHotstring
	Menu, Adverbs, Add, vm`tvraiment, TRY_TrayMenuHotstring
	Menu, Adverbs, Add, bcp`tbeaucoup, TRY_TrayMenuHotstring
	Menu, Adverbs, Add, tàf`ttout à fait, TRY_TrayMenuHotstring
	Menu, Adverbs, Add, tlm`ttellement, TRY_TrayMenuHotstring
	Menu, Adverbs, Add, b&`tbien, TRY_TrayMenuHotstring
	Menu, Adverbs, Add, mx`tmieux, TRY_TrayMenuHotstring
	Menu, Adverbs, Add, deds`tdedans, TRY_TrayMenuHotstring
	Menu, Adverbs, Add, deh`tdehors, TRY_TrayMenuHotstring
	Menu, Adverbs, Add, partt`tpartout, TRY_TrayMenuHotstring
	Menu, Adverbs, Add, ens`tensemble, TRY_TrayMenuHotstring
	Menu, Adverbs, Add
	Menu, Adverbs, Add, prtt`tpourtant, TRY_TrayMenuHotstring
	Menu, Adverbs, Add, nimp`tn'importe, TRY_TrayMenuHotstring
	Menu, Adverbs, Add, seult`tseulement, TRY_TrayMenuHotstring
	Menu, Adverbs, Add, vc`tvoici, TRY_TrayMenuHotstring
	Menu, Adverbs, Add, vl`tvoilà, TRY_TrayMenuHotstring
	Menu, Adverbs, Add, dj`tdéjà, TRY_TrayMenuHotstring
	Menu, Adverbs, Add, svt`tsouvent, TRY_TrayMenuHotstring
	Menu, Adverbs, Add, env`tenviron, TRY_TrayMenuHotstring
	Menu, Adverbs, Add, pe`tpeut-être, TRY_TrayMenuHotstring
	Menu, Adverbs, Add, pe'`tp't-êt', TRY_TrayMenuHotstring
	Menu, Adverbs, Add, tjrs`ttoujours , TRY_TrayMenuHotstring
	Menu, Adverbs, Add, tdm`ttout de même , TRY_TrayMenuHotstring
	Menu, Adverbs, Add, p`tpas, TRY_TrayMenuHotstring
	Menu, Adverbs, Add, hl`thélas, TRY_TrayMenuHotstring
	Menu, Adverbs, Add, jms`tjamais, TRY_TrayMenuHotstring
	Menu, Adverbs, Add
	Menu, Adverbs, Add, h`thein, TRY_TrayMenuHotstring
	Menu, Adverbs, Add, vi`toui, TRY_TrayMenuHotstring
	Menu, Adverbs, Add, ttf`ttoutefois, TRY_TrayMenuHotstring
	Menu, Adverbs, Add, nm`tnéanmoins, TRY_TrayMenuHotstring
	Menu, Adverbs, Add, parex`tpar exemple, TRY_TrayMenuHotstring
	Menu, Adverbs, Add, stp`ts'il te plaît, TRY_TrayMenuHotstring
	Menu, Adverbs, Add, svp`ts'il vous plaît, TRY_TrayMenuHotstring
	Menu, Adverbs, Add, cdlt`tcordialement, TRY_TrayMenuHotstring

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	; Positions :
	;;;;;;;;;;;;;

	Menu, Positions, Add, avt`tavant, TRY_TrayMenuHotstring
	Menu, Positions, Add, dvt`tdevant, TRY_TrayMenuHotstring
	Menu, Positions, Add, dr`tderrière, TRY_TrayMenuHotstring
	Menu, Positions, Add, dbt`tdebout, TRY_TrayMenuHotstring
	Menu, Positions, Add, ds`tdans, TRY_TrayMenuHotstring
	Menu, Positions, Add, dh`tdehors, TRY_TrayMenuHotstring
	Menu, Positions, Add, lb`tlà-bas, TRY_TrayMenuHotstring
	Menu, Positions, Add, dp`tdepuis, TRY_TrayMenuHotstring
	Menu, Positions, Add, pdt`tpendant, TRY_TrayMenuHotstring
	Menu, Positions, Add, jq`tjusque, TRY_TrayMenuHotstring
	Menu, Positions, Add, vr`tvers, TRY_TrayMenuHotstring
	Menu, Positions, Add, cz`tchez, TRY_TrayMenuHotstring
	Menu, Positions, Add, atr`tautour, TRY_TrayMenuHotstring
	Menu, Positions, Add, apr`taprès, TRY_TrayMenuHotstring
	Menu, Positions, Add
	Menu, Positions, Add, apd`tà partir de, TRY_TrayMenuHotstring
	Menu, Positions, Add, pm`tparmi, TRY_TrayMenuHotstring
	Menu, Positions, Add, av`tavec, TRY_TrayMenuHotstring
	Menu, Positions, Add, sf`tsauf, TRY_TrayMenuHotstring
	Menu, Positions, Add, ss`tsans, TRY_TrayMenuHotstring
	Menu, Positions, Add, s_`tsur, TRY_TrayMenuHotstring
	Menu, Positions, Add, _s`tsous, TRY_TrayMenuHotstring
	Menu, Positions, Add, dess`tdessous, TRY_TrayMenuHotstring
	Menu, Positions, Add
	Menu, Positions, Add, pr`tpour, TRY_TrayMenuHotstring
	Menu, Positions, Add, ctre`tcontre, TRY_TrayMenuHotstring
	Menu, Positions, Add, vàv`tvis-à-vis, TRY_TrayMenuHotstring
	Menu, Positions, Add, cm`tcomme, TRY_TrayMenuHotstring
	Menu, Positions, Add, af`tafin, TRY_TrayMenuHotstring
	Menu, Positions, Add, sl`tselon, TRY_TrayMenuHotstring
	Menu, Positions, Add, mg`tmalgré, TRY_TrayMenuHotstring
	Menu, Positions, Add, qt`tquant, TRY_TrayMenuHotstring
	Menu, Positions, Add, lx`tlieux, TRY_TrayMenuHotstring
	Menu, Positions, Add, ald`tau lieu de, TRY_TrayMenuHotstring

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	; Pronuns :
	;;;;;;;;;;;

	Menu, Pronuns, Add, cert&&`tcertain, TRY_TrayMenuHotstring
	Menu, Pronuns, Add, chq`tchaque, TRY_TrayMenuHotstring
	Menu, Pronuns, Add, tt`ttout, TRY_TrayMenuHotstring
	Menu, Pronuns, Add, ts`ttous, TRY_TrayMenuHotstring
	Menu, Pronuns, Add
	Menu, Pronuns, Add, ns`tnous, TRY_TrayMenuHotstring
	Menu, Pronuns, Add, vs`tvous, TRY_TrayMenuHotstring
	Menu, Pronuns, Add, u2`ttoi aussi, TRY_TrayMenuHotstring
	Menu, Pronuns, Add, cx`tceux, TRY_TrayMenuHotstring
	Menu, Pronuns, Add
	Menu, Pronuns, Add, l&&`tl'un, TRY_TrayMenuHotstring
	Menu, Pronuns, Add, d&&`td'un, TRY_TrayMenuHotstring
	Menu, Pronuns, Add, dt`tdont, TRY_TrayMenuHotstring

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	; Some :
	;;;;;;;;

	Menu, Some, Add, r&`trien, TRY_TrayMenuHotstring
	Menu, Some, Add, ca`tça, TRY_TrayMenuHotstring
	Menu, Some, Add, clc`tcelui-ci, TRY_TrayMenuHotstring
	Menu, Some, Add, qq`tquelque, TRY_TrayMenuHotstring
	Menu, Some, Add, qlc`tquelconque, TRY_TrayMenuHotstring
	Menu, Some, Add, qic`tquiconque, TRY_TrayMenuHotstring
	Menu, Some, Add
	Menu, Some, Add, qn`tquelqu'un, TRY_TrayMenuHotstring
	Menu, Some, Add, qns`tquelques-un, TRY_TrayMenuHotstring
	Menu, Some, Add, qnes`tquelques unes, TRY_TrayMenuHotstring
	Menu, Some, Add, qnes`tquelques unes, TRY_TrayMenuHotstring
	Menu, Some, Add, +r`tplusieurs, TRY_TrayMenuHotstring
	Menu, Some, Add
	Menu, Some, Add, qc`tquelque chose, TRY_TrayMenuHotstring
	Menu, Some, Add, qp`tquelque part, TRY_TrayMenuHotstring
	Menu, Some, Add, qf`tquelque fois, TRY_TrayMenuHotstring
	Menu, Some, Add, dv`tdivers, TRY_TrayMenuHotstring
	Menu, Some, Add
	Menu, Some, Add, dx`tdeux, TRY_TrayMenuHotstring
	Menu, Some, Add, trs`ttrois, TRY_TrayMenuHotstring
	Menu, Some, Add, cq`tcinq, TRY_TrayMenuHotstring
	Menu, Some, Add, nf`tneuf, TRY_TrayMenuHotstring
	Menu, Some, Add, dze`tdouze, TRY_TrayMenuHotstring
	Menu, Some, Add, trz`ttreize, TRY_TrayMenuHotstring
	Menu, Some, Add, vgt`tvingt, TRY_TrayMenuHotstring
	Menu, Some, Add, 4ante`tquarante, TRY_TrayMenuHotstring
	Menu, Some, Add, 5ante`tcinquante, TRY_TrayMenuHotstring
	Menu, Some, Add, 6ante`tsoixante, TRY_TrayMenuHotstring
	Menu, Some, Add, 7ante`tsoixante-dix, TRY_TrayMenuHotstring
	Menu, Some, Add, 4vgt`tquatre-vingt, TRY_TrayMenuHotstring
	Menu, Some, Add, 9dix`tquatre-vingt-dix, TRY_TrayMenuHotstring

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	; Adjectives :
	;;;;;;;;;;;;;;

	Menu, Adjectives, Add, fx`tfaux, TRY_TrayMenuHotstring
	Menu, Adjectives, Add, std`tstandard, TRY_TrayMenuHotstring
	Menu, Adjectives, Add, dble`tdouble, TRY_TrayMenuHotstring
	Menu, Adjectives, Add, bx`tbeaux, TRY_TrayMenuHotstring
	Menu, Adjectives, Add, grd`tgrand, TRY_TrayMenuHotstring
	Menu, Adjectives, Add, lrd`tlourd, TRY_TrayMenuHotstring
	Menu, Adjectives, Add, mv`tmauvais, TRY_TrayMenuHotstring
	Menu, Adjectives, Add, lg`tlong, TRY_TrayMenuHotstring
	Menu, Adjectives, Add, crt`tcourt, TRY_TrayMenuHotstring
	Menu, Adjectives, Add, gche`tgauche, TRY_TrayMenuHotstring
	Menu, Adjectives, Add, drt`tdroit, TRY_TrayMenuHotstring
	Menu, Adjectives, Add, ht`thaut, TRY_TrayMenuHotstring
	Menu, Adjectives, Add, rd`trond, TRY_TrayMenuHotstring
	Menu, Adjectives, Add, horiz`thorizontal, TRY_TrayMenuHotstring
	Menu, Adjectives, Add
	Menu, Adjectives, Add, cj`tci-joint, TRY_TrayMenuHotstring
	Menu, Adjectives, Add, nvo`tnouveau, TRY_TrayMenuHotstring
	Menu, Adjectives, Add, nvl`tnouvel, TRY_TrayMenuHotstring
	Menu, Adjectives, Add, dispo`tdisponib, TRY_TrayMenuHotstring
	Menu, Adjectives, Add, indispo`tindisponib, TRY_TrayMenuHotstring
	Menu, Adjectives, Add
	Menu, Adjectives, Add, st`tsaint, TRY_TrayMenuHotstring
	Menu, Adjectives, Add, mdr`tmort de rire, TRY_TrayMenuHotstring
	Menu, Adjectives, Add, dsl`tdésolé, TRY_TrayMenuHotstring
	Menu, Adjectives, Add, chd`tchaud, TRY_TrayMenuHotstring
	Menu, Adjectives, Add, frd`tfroid, TRY_TrayMenuHotstring

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	; Things :
	;;;;;;;;;;

	Menu, Things, Add, msg`tmessage, TRY_TrayMenuHotstring
	Menu, Things, Add, pj`tpièce jointe, TRY_TrayMenuHotstring
	Menu, Things, Add, doc`tdocument, TRY_TrayMenuHotstring
	Menu, Things, Add, txt`ttexte, TRY_TrayMenuHotstring
	Menu, Things, Add, chp`tchamp, TRY_TrayMenuHotstring
	Menu, Things, Add, rmq`tremarqu, TRY_TrayMenuHotstring
	Menu, Things, Add, df`tdéfaut, TRY_TrayMenuHotstring
	Menu, Things, Add, nbr`tnombre, TRY_TrayMenuHotstring
	Menu, Things, Add, trvl`ttravail, TRY_TrayMenuHotstring
	Menu, Things, Add, jx`tjeux, TRY_TrayMenuHotstring
	Menu, Things, Add, yx`tyeux, TRY_TrayMenuHotstring
	Menu, Things, Add, pds`tpoids, TRY_TrayMenuHotstring
	Menu, Things, Add, src`tsource, TRY_TrayMenuHotstring
	Menu, Things, Add, grp`tgroupe, TRY_TrayMenuHotstring
	Menu, Things, Add, trp`ttroupe, TRY_TrayMenuHotstring
	Menu, Things, Add, rf`tréféren, TRY_TrayMenuHotstring
	Menu, Things, Add, rte`troute, TRY_TrayMenuHotstring
	Menu, Things, Add, étab`tétablissement, TRY_TrayMenuHotstring
	Menu, Things, Add, philo`tphilosophie, TRY_TrayMenuHotstring

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	; Actions :
	;;;;;;;;;;;

	Menu, Actions, Add, pb`, prob`tproblème, TRY_TrayMenuHotstring
	Menu, Actions, Add, fd`tfond, TRY_TrayMenuHotstring
	Menu, Actions, Add, rv`trendez-vous, TRY_TrayMenuHotstring
	Menu, Actions, Add, prop`tproposition, TRY_TrayMenuHotstring
	Menu, Actions, Add, proba`tprobabilité, TRY_TrayMenuHotstring
	Menu, Actions, Add, tx`ttaux, TRY_TrayMenuHotstring
	Menu, Actions, Add, cp`tcoup, TRY_TrayMenuHotstring
	Menu, Actions, Add, bd`tbond, TRY_TrayMenuHotstring
	Menu, Actions, Add
	Menu, Actions, Add, xp`texpéri, TRY_TrayMenuHotstring
	Menu, Actions, Add, cfg`tconfig, TRY_TrayMenuHotstring
	Menu, Actions, Add, fc`tfonction, TRY_TrayMenuHotstring
	Menu, Actions, Add, ctrl`tcontrôle, TRY_TrayMenuHotstring
	Menu, Actions, Add, cr`tcompte-rendu, TRY_TrayMenuHotstring
	Menu, Actions, Add, pts`tpoints, TRY_TrayMenuHotstring
	Menu, Actions, Add, màd`tmise à disposition, TRY_TrayMenuHotstring
	Menu, Actions, Add, màj`tmise à jour, TRY_TrayMenuHotstring
	Menu, Actions, Add, mef`tmise en forme, TRY_TrayMenuHotstring
	Menu, Actions, Add, ccl`tconclusion, TRY_TrayMenuHotstring
	Menu, Actions, Add, suppr`tsuppression, TRY_TrayMenuHotstring
	Menu, Actions, Add
	Menu, Actions, Add, trt`ttraitement, TRY_TrayMenuHotstring
	Menu, Actions, Add, event`tévénement, TRY_TrayMenuHotstring
	Menu, Actions, Add, mvt`tmouvement, TRY_TrayMenuHotstring
	Menu, Actions, Add, chg`tchange, TRY_TrayMenuHotstring

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	; Computing :
	;;;;;;;;;;;;;

	Menu, Computing, Add, prog`tprogramme, TRY_TrayMenuHotstring
	Menu, Computing, Add, appli`tapplication, TRY_TrayMenuHotstring
	Menu, Computing, Add, cmde`tcommande, TRY_TrayMenuHotstring
	Menu, Computing, Add, fic`tfichier, TRY_TrayMenuHotstring
	Menu, Computing, Add, enreg`tenregistrement, TRY_TrayMenuHotstring
	Menu, Computing, Add, btn`tbouton, TRY_TrayMenuHotstring
	Menu, Computing, Add, dim`tdimension, TRY_TrayMenuHotstring
	Menu, Computing, Add, rg`trang, TRY_TrayMenuHotstring
	Menu, Computing, Add
	Menu, Computing, Add, agt`tagent, TRY_TrayMenuHotstring
	Menu, Computing, Add, prodr`tproducteur, TRY_TrayMenuHotstring
	Menu, Computing, Add, conso`tconsommateur, TRY_TrayMenuHotstring
	Menu, Computing, Add, cpte`tcompte, TRY_TrayMenuHotstring
	Menu, Computing, Add, mdp`tmot de passe, TRY_TrayMenuHotstring
	Menu, Computing, Add
	Menu, Computing, Add, envt`tenvironnement, TRY_TrayMenuHotstring
	Menu, Computing, Add, bàs`tbac à sable, TRY_TrayMenuHotstring
	Menu, Computing, Add, dév`tdéveloppement, TRY_TrayMenuHotstring
	Menu, Computing, Add, inté`tintégration, TRY_TrayMenuHotstring
	Menu, Computing, Add, rec`trecette, TRY_TrayMenuHotstring
	Menu, Computing, Add, pprod`tpré-production, TRY_TrayMenuHotstring
	Menu, Computing, Add, prod`tproduction, TRY_TrayMenuHotstring
	Menu, Computing, Add
	Menu, Computing, Add, pf`tplateforme, TRY_TrayMenuHotstring
	Menu, Computing, Add, specs`tspécifications, TRY_TrayMenuHotstring
	Menu, Computing, Add, bt`tBrique Technique, TRY_TrayMenuHotstring
	Menu, Computing, Add, modif`tmodification, TRY_TrayMenuHotstring
	Menu, Computing, Add, qualif`tqualification, TRY_TrayMenuHotstring
	Menu, Computing, Add, ver`tversion, TRY_TrayMenuHotstring
	Menu, Computing, Add, liv`tlivraison, TRY_TrayMenuHotstring
	Menu, Computing, Add, conf`tconfiguration, TRY_TrayMenuHotstring
	Menu, Computing, Add, planif`tplanification, TRY_TrayMenuHotstring
	Menu, Computing, Add, mei`tmise en intégration, TRY_TrayMenuHotstring
	Menu, Computing, Add, mep`tmise en production, TRY_TrayMenuHotstring

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	; Time :
	;;;;;;;;

	Menu, Time, Add, tps`ttemps, TRY_TrayMenuHotstring
	Menu, Time, Add, smn`tsemaine, TRY_TrayMenuHotstring
	Menu, Time, Add, jr`tjour, TRY_TrayMenuHotstring
	Menu, Time, Add, hre`theure, TRY_TrayMenuHotstring
	Menu, Time, Add, dsm`tdésormais, TRY_TrayMenuHotstring
	Menu, Time, Add, dl`tdès lors, TRY_TrayMenuHotstring
	Menu, Time, Add, ec`tencore, TRY_TrayMenuHotstring
	Menu, Time, Add, atf`tautrefois, TRY_TrayMenuHotstring
	Menu, Time, Add, avhr`tavant-hier, TRY_TrayMenuHotstring
	Menu, Time, Add, hr`thier, TRY_TrayMenuHotstring
	Menu, Time, Add, ef`tenfin, TRY_TrayMenuHotstring
	Menu, Time, Add, maintt`tmaintenant, TRY_TrayMenuHotstring
	Menu, Time, Add, sd`tsoudain, TRY_TrayMenuHotstring
	Menu, Time, Add, ast`taussitôt, TRY_TrayMenuHotstring
	Menu, Time, Add, tàc`ttout à coup, TRY_TrayMenuHotstring
	Menu, Time, Add, dàp`tdès à présent, TRY_TrayMenuHotstring
	Menu, Time, Add, mmt`tmoment, TRY_TrayMenuHotstring
	Menu, Time, Add, auj`taujourd'hui, TRY_TrayMenuHotstring
	Menu, Time, Add, aprm`taprès-midi, TRY_TrayMenuHotstring
	Menu, Time, Add, dm`tdemain, TRY_TrayMenuHotstring
	Menu, Time, Add, apdm`taprès-demain, TRY_TrayMenuHotstring
	Menu, Time, Add, bto`tbientôt, TRY_TrayMenuHotstring
	Menu, Time, Add
	Menu, Time, Add, lun`tlundi, TRY_TrayMenuHotstring
	Menu, Time, Add, mar`tmardi, TRY_TrayMenuHotstring
	Menu, Time, Add, mercr`tmercredi, TRY_TrayMenuHotstring
	Menu, Time, Add, vendr`tvendredi, TRY_TrayMenuHotstring
	Menu, Time, Add, dim`tdimanche, TRY_TrayMenuHotstring
	Menu, Time, Add
	Menu, Time, Add, w-e`tweek-end, TRY_TrayMenuHotstring
	Menu, Time, Add, fréq`tfréquen, TRY_TrayMenuHotstring
	Menu, Time, Add, hebdo`thebdomadaire, TRY_TrayMenuHotstring
	Menu, Time, Add
	Menu, Time, Add, janv`tjanvier, TRY_TrayMenuHotstring
	Menu, Time, Add, fév`tfévrier, TRY_TrayMenuHotstring
	Menu, Time, Add, oct`toctobre, TRY_TrayMenuHotstring
	Menu, Time, Add, nov`tnovembre, TRY_TrayMenuHotstring
	Menu, Time, Add, déc`tdécembre, TRY_TrayMenuHotstring

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	; Various :
	;;;;;;;;;;;

	Menu, Various, Add, ab`tArnaud BeLO., TRY_TrayMenuHotstring
	Menu, Various, Add, AB`tArnaud BELONOSCHKIN, TRY_TrayMenuHotstring
	Menu, Various, Add, mkw`tMiuka WYBORSKA, TRY_TrayMenuHotstring
	Menu, Various, Add, bàb`tBande à Balk, TRY_TrayMenuHotstring
	Menu, Various, Add, alodb`tÀ l'Ouest des Balkans, TRY_TrayMenuHotstring
	Menu, Various, Add, bb`tbÜlbÜl, TRY_TrayMenuHotstring
	Menu, Various, Add, slt`tsalut, TRY_TrayMenuHotstring
	Menu, Various, Add, bjr`tbonjour, TRY_TrayMenuHotstring
	Menu, Various, Add, àb`tÀ bientôt, TRY_TrayMenuHotstring
	Menu, Various, Add, bs`tbises, TRY_TrayMenuHotstring
	Menu, Various, Add, cie`tcompagnie, TRY_TrayMenuHotstring
	Menu, Various, Add, dgt`tdoigt, TRY_TrayMenuHotstring
	Menu, Various, Add, frt`tfront, TRY_TrayMenuHotstring
	Menu, Various, Add, sg`tsang, TRY_TrayMenuHotstring
	Menu, Various, Add, bp`tbonne partie, TRY_TrayMenuHotstring
	Menu, Various, Add, gg`thave a good game, TRY_TrayMenuHotstring
	Menu, Various, Add, hf`thave fun !, TRY_TrayMenuHotstring
	Menu, Various, Add, mc`tmerci, TRY_TrayMenuHotstring
	Menu, Various, Add, thx`tthanks, TRY_TrayMenuHotstring

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	; Suffixes :
	;;;;;;;;;;;;

	Menu, Suffixes, Add, CapsLock + A`tant, TRY_TrayMenuHotstring
	Menu, Suffixes, Add, CapsLock + B`table , TRY_TrayMenuHotstring
	Menu, Suffixes, Add, CapsLock + E`tence, TRY_TrayMenuHotstring
	Menu, Suffixes, Add, CapsLock + G`tage, TRY_TrayMenuHotstring
	Menu, Suffixes, Add, CapsLock + H`tchie, TRY_TrayMenuHotstring
	Menu, Suffixes, Add, CapsLock + J`tgie, TRY_TrayMenuHotstring
	Menu, Suffixes, Add, CapsLock + L`telle, TRY_TrayMenuHotstring
	Menu, Suffixes, Add, CapsLock + M`tisme, TRY_TrayMenuHotstring
	Menu, Suffixes, Add, CapsLock + N`taison, TRY_TrayMenuHotstring
	Menu, Suffixes, Add, CapsLock + O`ttion, TRY_TrayMenuHotstring
	Menu, Suffixes, Add, CapsLock + Q`tique, TRY_TrayMenuHotstring
	Menu, Suffixes, Add, CapsLock + R`teur, TRY_TrayMenuHotstring
	Menu, Suffixes, Add, CapsLock + S`tesse, TRY_TrayMenuHotstring
	Menu, Suffixes, Add, CapsLock + T`tement, TRY_TrayMenuHotstring
	Menu, Suffixes, Add, CapsLock + Y`tille, TRY_TrayMenuHotstring
	Menu, Suffixes, Add, CapsLock + Z`teuse, TRY_TrayMenuHotstring

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	; Login :
	;;;;;;;;;

	TRY_AddMenuItem("Login", "           Win +              Enter`tPassword", "LOG_TrayMenuPassword", "shell32.dll", 105)
	TRY_AddMenuItem("Login", "           Win + Shift + Enter`tWindows Login", "LOG_TrayMenuWindowsLogin", "shell32.dll", 16)
	TRY_AddMenuItem("Login", "Ctrl + Win + Shift + Enter`tWindows Domain Login", "LOG_TrayMenuDNSLogin", "shell32.dll", 19)
	TRY_AddMenuItem("Login", "Ctrl + Win +              B`tBank Account", "LOG_TrayMenuBankAccount", "mmcndmgr.dll", 109)
	TRY_AddMenuItem("Login", " Alt + Win +              B`tBank Pro Account", "LOG_TrayMenuBankProAccount", "mmcndmgr.dll", 109)
	TRY_AddMenuItem("Login", "           Win + Shift + B`tCB", "LOG_TrayMenuCB", "certmgr.dll")
	TRY_AddMenuItem("Login", "Ctrl + Win +              @`tMail addresses", "LOG_TrayMenuMailAddresses", "shell32.dll", 157)

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	; Case :
	;;;;;;;;

	TRY_AddMenuItem("Case", "{ Win } + { F8 }`tAffect selection")
	TRY_AddMenuItem("Case", "[ Ctrl ]`tAffect first word letters")
	TRY_AddMenuItem("Case", "[ Shift ]`tAct one step more")
	TRY_AddMenuItem("Case", "[ Alt ]`tInvert case")
	TRY_AddMenuItem("Case", "[ AltGr ]`tDisable text style")
	TRY_AddMenuItem("Case")
	TRY_AddMenuItem("Case", "           Win +                            F8`tlowercase", "TXT_TrayMenulowercase")
	TRY_AddMenuItem("Case", "           Win +               Shift + F8`tUPPERCASE", "TXT_TrayMenuUPPERCASE")
	TRY_AddMenuItem("Case")
	TRY_AddMenuItem("Case", "Ctrl + Win +               Shift + F8`tTitle Case", "TXT_TrayMenuTitleCase")
	TRY_AddMenuItem("Case", "Ctrl + Win + Alt +     Shift + F8`ttITLE cASE", "TXT_TrayMenuiNVERTtITLEcASE")
	TRY_AddMenuItem("Case")
	TRY_AddMenuItem("Case", "Ctrl + Win +                            F8`tSentence case", "TXT_TrayMenuSentencecase")
	TRY_AddMenuItem("Case", "Ctrl + Win + Alt +                  F8`tsENTENCE CASE", "TXT_TrayMenuiNVERTSENTENCECASE")
	TRY_AddMenuItem("Case")
	TRY_AddMenuItem("Case", "           Win + Alt +                  F8`tInVeRtCaSe", "TXT_TrayMenuInverTCasE")
	TRY_AddMenuItem("Case", "           Win + Alt +     Shift + F8`trANdOmcAsE", "TXT_TrayMenurANdOmcAsE")
	TRY_AddMenuItem("Case")
	TRY_AddMenuItem("Case", "           Win + AltGr +              F8`tNo style", "TXT_TrayMenuNoStyle")
	TRY_AddMenuItem("Case", "           Win + AltGr + Shift + F8`tFormat punctuation", "TXT_TrayMenuFormatPunctuation")

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	; ClipBoard :
	;;;;;;;;;;;;;

	TRY_AddMenuItem("ClipBoard", "Win +                            H`t&History", "TXT_ShowClipBoardHistoryManager")
	TRY_AddMenuItem("ClipBoard")
	TRY_AddMenuItem("ClipBoard", "            AltGr +              PrintScreen`tCapture &Text for &Copy", "TXT_CaptureText")
	TRY_AddMenuItem("ClipBoard", "            AltGr + Shift + PrintScreen`tCapture Text for &Append", "TXT_CaptureAppendText")
	TRY_AddMenuItem("ClipBoard", "Win + AltGr +              PrintScreen`t&Unicode Art", "SCR_CaptureUnicode")
	TRY_AddMenuItem("ClipBoard", "Win + AltGr + Shift + PrintScreen`t&ASCII Art", "SCR_CaptureASCII")
	TRY_AddMenuItem("ClipBoard")
	TRY_AddMenuItem("ClipBoard")
	TRY_AddMenuItem("ClipBoard", "[ Ctrl ]`tErase previous word")
	TRY_AddMenuItem("ClipBoard", "[ Alt ]`tErase next word")
	TRY_AddMenuItem("ClipBoard", "[ Shift ]`tErase && cut")
	TRY_AddMenuItem("ClipBoard")
	TRY_AddMenuItem("ClipBoard", "Ctrl +                        BackSpace`tDelete &Previous Word", "KBD_TrayMenuDeletePreviousWord")
	TRY_AddMenuItem("ClipBoard", "Ctrl + Alt +              BackSpace`tDelete &Current Word", "KBD_TrayMenuDeleteCurrentWord")
	TRY_AddMenuItem("ClipBoard", "           Alt +              BackSpace`tDelete &Next Word", "KBD_TrayMenuDeleteNextWord")
	TRY_AddMenuItem("ClipBoard")
	TRY_AddMenuItem("ClipBoard", "Ctrl +           Shift + BackSpace`tCut &Previous Word", "KBD_TrayMenuCutPreviousWord")
	TRY_AddMenuItem("ClipBoard", "Ctrl + Alt + Shift + BackSpace`tCut &Current Word", "KBD_TrayMenuCutCurrentWord")
	TRY_AddMenuItem("ClipBoard", "           Alt + Shift + BackSpace`tCut &Next Word", "KBD_TrayMenuCutNextWord")
	TRY_AddMenuItem("ClipBoard")
	TRY_AddMenuItem("ClipBoard")
	TRY_AddMenuItem("ClipBoard", "[ Alt ]`tCopy to alternate clipboard")
	TRY_AddMenuItem("ClipBoard", "[ Shift ]`tCopy plain text")
	TRY_AddMenuItem("ClipBoard", "[ Insert | Delete ]`tAppends content to clipboard")
	TRY_AddMenuItem("ClipBoard")
	TRY_AddMenuItem("ClipBoard", "Ctrl + Alt +              C`tAlternate Copy", "TXT_TrayMenuCopyAlternate")
	TRY_AddMenuItem("ClipBoard", "Ctrl + Alt +              X`tAlternate Cut", "TXT_TrayMenuCutAlternate")
	TRY_AddMenuItem("ClipBoard", "Ctrl + Alt +              V`tAlternate Paste", "TXT_TrayMenuPasteAlternate")
	TRY_AddMenuItem("ClipBoard")
	TRY_AddMenuItem("ClipBoard", "Ctrl + Alt + Shift + C`tAlternate Copy                 Plain Text", "TXT_TrayMenuCopyPlainAlternateText")
	TRY_AddMenuItem("ClipBoard", "Ctrl + Alt + Shift + Insert`tAlternate Append             Plain Text", "TXT_TrayMenuAppendPlainAlternateText")
	TRY_AddMenuItem("ClipBoard", "Ctrl + Alt + Shift + Delete`tAlternate Append && Cut Plain Text", "TXT_TrayMenuAppendCutPlainAlternateText")
	TRY_AddMenuItem("ClipBoard", "Ctrl + Alt + Shift + X`tAlternate Cut                    Plain Text", "TXT_TrayMenuCutPlainAlternateText")
	TRY_AddMenuItem("ClipBoard", "Ctrl + Alt + Shift + V`tAlternate Paste                 Plain Text", "TXT_TrayMenuPastePlainAlternateText")
	TRY_AddMenuItem("ClipBoard")
	TRY_AddMenuItem("ClipBoard", "Ctrl +           Shift + C`t             Copy                  Plain Text", "TXT_TrayMenuCopyPlainText")
	TRY_AddMenuItem("ClipBoard", "Ctrl +           Shift + Insert`t              Append             Plain Text", "TXT_TrayMenuAppendPlainText")
	TRY_AddMenuItem("ClipBoard", "Ctrl +           Shift + Delete`t                Append && Cut Plain Text", "TXT_TrayMenuAppendCutPlainText")
	TRY_AddMenuItem("ClipBoard", "Ctrl +           Shift + X`t             Cut                     Plain Text", "TXT_TrayMenuCutPlainText")
	TRY_AddMenuItem("ClipBoard", "Ctrl +           Shift + V`t             Paste                 Plain Text", "TXT_TrayMenuPastePlainText")

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	; Audio :
	;;;;;;;;;

	If (APP_Mp3EditorPath) {
		TRY_AddMenuItem("Audio", "Ctrl + Win +             BackSpace`t&MP3Editor", "APP_MP3Editor", APP_Mp3EditorPath)
	}
	If (APP_MediaMonkeyPath) {
		TRY_AddMenuItem("Audio", "Ctrl + Win +              M`t&MediaMonkey", "APP_MediaMonkey", APP_MediaMonkeyPath)
	}
	If (APP_WindowsMediaPlayerPath) {
		TRY_AddMenuItem("Audio", "           Win +              W`t&WMP", "APP_WMP", APP_WindowsMediaPlayerPath)
	}
	TRY_AddMenuItem("Audio")
	TRY_AddMenuItem("Audio", "                                    Pause`t&On/Off", "AUD_Mute", "avtapi.dll", 3)
	TRY_AddMenuItem("Audio")
	TRY_AddMenuItem("Audio")
	TRY_AddMenuItem("Audio", "{ Win } + { Up | Down }`tSet sound volume")
	TRY_AddMenuItem("Audio", "{ Alt }`tAffect Wave instead of Master")
	TRY_AddMenuItem("Audio", "{ Control }`tStep by 1%")
	TRY_AddMenuItem("Audio", "{ Shift }`tStep by 10%")
	TRY_AddMenuItem("Audio")
	TRY_AddMenuItem("Audio", "Ctrl + Win +              Up`tFine Master Sound &Up          ", "AUD_MasterVolumeFineUp", "WpdShext.dll", 28)
	TRY_AddMenuItem("Audio", "           Win +              Up`tMaster Sound &Up          ", "AUD_MasterVolumeUp", "WpdShext.dll", 26)
	TRY_AddMenuItem("Audio", "           Win + Shift + Up`tMaster Sound &Up     ++", "AUD_MasterVolumeUpUp", "WpdShext.dll", 26)
	TRY_AddMenuItem("Audio")
	TRY_AddMenuItem("Audio", "Ctrl + Win +              Down`tFine Master Sound &Down     ", "AUD_MasterVolumeFineDown", "WpdShext.dll", 29)
	TRY_AddMenuItem("Audio", "           Win +              Down`tMaster Sound &Down     ", "AUD_MasterVolumeDown", "WpdShext.dll", 27)
	TRY_AddMenuItem("Audio", "           Win + Shift + Down`tMaster Sound &Down --", "AUD_MasterVolumeDownDown", "WpdShext.dll", 27)
	TRY_AddMenuItem("Audio")
	TRY_AddMenuItem("Audio", "Ctrl + Alt + Win +              Up`tFine Wave Sound &Up          ", "AUD_WaveVolumeFineUp", "WpdShext.dll", 28)
	TRY_AddMenuItem("Audio", "           Alt + Win +              Up`tWave Sound &Up          ", "AUD_WaveVolumeUp", "WpdShext.dll", 26)
	TRY_AddMenuItem("Audio", "           Alt + Win + Shift + Up`tWave Sound &Up     ++", "AUD_WaveVolumeUpUp", "WpdShext.dll", 26)
	TRY_AddMenuItem("Audio")
	TRY_AddMenuItem("Audio", "Ctrl + Alt + Win +              Down`tFine Wave Sound &Down     ", "AUD_WaveVolumeFineDown", "WpdShext.dll", 29)
	TRY_AddMenuItem("Audio", "           Alt + Win +              Down`tWave Sound &Down     ", "AUD_WaveVolumeDown", "WpdShext.dll", 27)
	TRY_AddMenuItem("Audio", "           Alt + Win + Shift + Down`tWave Sound &Down --", "AUD_WaveVolumeDownDown", "WpdShext.dll", 27)

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	; Power :
	;;;;;;;;;

	TRY_AddMenuItem("Power", "           Win +                        ScrollLock`t&BSOD", "PWR_BSOD", "wmp.dll", 9)

	TRY_AddMenuItem("Power")
	TRY_AddMenuItem("Power")

	TRY_AddMenuItem("Power", "{ Win } + { L }`tKeep user session")
	TRY_AddMenuItem("Power", "{ Ctrl }`tManage screen")
	TRY_AddMenuItem("Power", "{ Alt }`tDisable power")
	TRY_AddMenuItem("Power", "{ Shift }`tAct one step more")
	TRY_AddMenuItem("Power")
	TRY_AddMenuItem("Power", "Ctrl + Win +                        L`tScreen Sa&ver", "PWR_Screensaver", "shell32.dll", 26)
	TRY_AddMenuItem("Power", "Ctrl + Win +           Shift + L`tScreen &Off", "PWR_ScreenOff", "shell32.dll", 26)
	TRY_AddMenuItem("Power", "           Win +                        L`tLock Station", "PWR_LockStation", "shell32.dll", 48)
	TRY_AddMenuItem("Power", "           Win +           Shift + L`tForce Lock Station", "PWR_LockStation", "shell32.dll", 48)
	TRY_AddMenuItem("Power")
	TRY_AddMenuItem("Power", "Ctrl + Win + Alt +              L`t&Suspend", "PWR_Suspend", "shell32.dll", 113)
	TRY_AddMenuItem("Power", "Ctrl + Win + Alt + Shift + L`t&Hibernate", "PWR_Hibernate", "shell32.dll", 113)

	TRY_AddMenuItem("Power")
	TRY_AddMenuItem("Power")

	TRY_AddMenuItem("Power", "{ Win } + { F12 }`tAbort user session")
	TRY_AddMenuItem("Power", "{ Ctrl }`tJust log off")
	TRY_AddMenuItem("Power", "{ Alt }`tJust shut down")
	TRY_AddMenuItem("Power", "{ Shift }`tForce operation")
	TRY_AddMenuItem("Power")
	TRY_AddMenuItem("Power", "Ctrl + Win +                        F12`t&Log Off", "PWR_LogOff", "shell32.dll", 45)
	TRY_AddMenuItem("Power", "Ctrl + Win +           Shift + F12`tForce &Log Off", "PWR_ForceLogOff", "shell32.dll", 45)
	TRY_AddMenuItem("Power")
	TRY_AddMenuItem("Power", "           Win + Alt +              F12`t&Shutdown", "PWR_Shutdown", "shell32.dll", 28)
	TRY_AddMenuItem("Power", "           Win + Alt + Shift + F12`t&Force Shutdown", "PWR_ForceShutdown", "shell32.dll", 28)
	TRY_AddMenuItem("Power")
	TRY_AddMenuItem("Power", "           Win +                        F12`t&Restart", "PWR_Restart")
	TRY_AddMenuItem("Power", "           Win +           Shift + F12`t&Force Restart", "PWR_ForceRestart")
	TRY_AddMenuItem("Power")
	TRY_AddMenuItem("Power", "Ctrl + Win + Alt + Shift + F12`t&Delayed Shutdown", "PWR_DelayedShutdown", "shell32.dll", 28)

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	; Screen :
	;;;;;;;;;;

	TRY_AddMenuItem("Screen", "{ AltGr }`tMouse &Position")
	TRY_AddMenuItem("Screen", "[ Ctrl ]`t&Horizontal Lock")
	TRY_AddMenuItem("Screen", "[ Shift ]`t&Vertical Lock")
	TRY_AddMenuItem("Screen")
	TRY_AddMenuItem("Screen", "{ Win } + { NumPad }`t&Move Mouse")
	TRY_AddMenuItem("Screen", "[ Ctrl ]`t&Small Step")
	TRY_AddMenuItem("Screen")
	TRY_AddMenuItem("Screen")
	TRY_AddMenuItem("Screen", "{ PrintScreen }`tCapture screen image")
	TRY_AddMenuItem("Screen", "[ Shift ]`tInclude mouse cursor")
	TRY_AddMenuItem("Screen", "[ Alt ]`tSave to file")
	TRY_AddMenuItem("Screen", "[ Win ]`tCapture active window")
	TRY_AddMenuItem("Screen", "[ Ctrl ]`tSelect capture zone")
	TRY_AddMenuItem("Screen")
	TRY_AddMenuItem("Screen", "                                             PrintScreen`tEntire &Desktop to ClipBoard", "SCR_TrayMenuDesktopClipBoardShot")
	TRY_AddMenuItem("Screen", "                                Shift + PrintScreen`tEntire &Desktop to ClipBoard ( +  Cursor)", "SCR_TrayMenuDesktopCursorClipBoardShot")
	TRY_AddMenuItem("Screen", "                       Alt +              PrintScreen`tEntire &Desktop to File", "SCR_TrayMenuDesktopFileShot")
	TRY_AddMenuItem("Screen", "                       Alt + Shift + PrintScreen`tEntire &Desktop to File ( +  Cursor)", "SCR_TrayMenuDesktopCursorFileShot")
	TRY_AddMenuItem("Screen")
	TRY_AddMenuItem("Screen", "           Win +                        PrintScreen`tActive &Window to ClipBoard", "SCR_TrayMenuWindowClipBoardShot")
	TRY_AddMenuItem("Screen", "           Win +           Shift + PrintScreen`tActive &Window to ClipBoard ( +  Cursor)", "SCR_TrayMenuWindowCursorClipBoardShot")
	TRY_AddMenuItem("Screen", "           Win + Alt +              PrintScreen`tActive &Window to File", "SCR_TrayMenuWindowFileShot")
	TRY_AddMenuItem("Screen", "           Win + Alt + Shift + PrintScreen`tActive &Window to File ( +  Cursor)", "SCR_TrayMenuWindowCursorFileShot")
	TRY_AddMenuItem("Screen")
	TRY_AddMenuItem("Screen", "Ctrl +                                   PrintScreen`t&Zone to ClipBoard", "SCR_ZoneClipBoardShot")
	TRY_AddMenuItem("Screen", "Ctrl +                      Shift + PrintScreen`t&Zone to ClipBoard ( +  Cursor)", "SCR_ZoneCursorClipBoardShot")
	TRY_AddMenuItem("Screen", "Ctrl +             Alt +             PrintScreen`t&Zone to File", "SCR_ZoneFileShot")
	TRY_AddMenuItem("Screen", "Ctrl +             Alt + Shift + PrintScreen`t&Zone to File ( +  Cursor)", "SCR_ZoneCursorFileShot")
	TRY_AddMenuItem("Screen")
	TRY_AddMenuItem("Screen", "Ctrl + Win + Alt +              PrintScreen`t&Magnifier", "SCR_Magnifier")
	TRY_AddMenuItem("Screen", "           Win +                        NumDot`t&Horizontal Ruler", "WIN_HorizontalRuler")
	TRY_AddMenuItem("Screen", "Ctrl + Win +                        NumDot`t&Vertical Ruler", "WIN_VerticalRuler")

	TRY_AddMenuItem("Screen")
	TRY_AddMenuItem("Screen")
	TRY_AddMenuItem("Screen", "{ Win } + { C }`tSelect screen pixel color")
	TRY_AddMenuItem("Screen", "[ Ctrl ]`tCopy hexa value")
	TRY_AddMenuItem("Screen", "[ Alt ]`tCopy RGB value")
	TRY_AddMenuItem("Screen", "[ Shift ]`tDisplay GUI")
	TRY_AddMenuItem("Screen")
	TRY_AddMenuItem("Screen", "Ctrl + Win +                       C`tHexa Color &Picker", "SCR_TrayMenuHexaColorPicker")
	TRY_AddMenuItem("Screen", "           Win + Alt +              C`tRGB  Color &Picker", "SCR_TrayMenuRGBColorPicker")
	TRY_AddMenuItem("Screen", "Ctrl + Win +           Shift + C`tHexa Color &Chooser", "SCR_HexaColorChooser")
	TRY_AddMenuItem("Screen", "           Win + Alt + Shift + C`tRGB  Color &Chooser", "SCR_RGBColorChooser")

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	; Windows :
	;;;;;;;;;;;

	TRY_AddMenuItem("Windows", "                       Alt +             LeftClick     on  Maximize`tMaximize on Next Screen", "WIN_TrayMenuMaximizeOnNextScreen")
	TRY_AddMenuItem("Windows", "                                Shift + LeftClick     on  Maximize`tMaximize on All Screens", "WIN_TrayMenuMaximizeOnAllScreens")
	TRY_AddMenuItem("Windows", "                                             MiddleClick  on  Maximize`tMaximize Vertically", "WIN_TrayMenuMaximizeVertically")
	TRY_AddMenuItem("Windows", "                                             RightClick    on  Maximize`tMaximize Horizontally", "WIN_TrayMenuMaximizeHorizontally")
	TRY_AddMenuItem("Windows", "           Win +          Shift + PageUp`tMaximize", "WIN_TrayMenuMaximize")
	TRY_AddMenuItem("Windows", "           Win +                       PageUp`tIncrease", "WIN_TrayMenuIncrease")
	TRY_AddMenuItem("Windows")
	TRY_AddMenuItem("Windows", "           Win +                       NumEnter`tRestore All", "WIN_RestoreAll")
	TRY_AddMenuItem("Windows", "           Win +          Shift + NumEnter`tRestore", "WIN_TrayMenuRestore")
	TRY_AddMenuItem("Windows")
	TRY_AddMenuItem("Windows", "           Win +                       PageDown`tDecrease", "WIN_TrayMenuDecrease")
	TRY_AddMenuItem("Windows", "           Win +          Shift + PageDown`tMinimize", "WIN_TrayMenuMinimize")
	TRY_AddMenuItem("Windows", "Ctrl + Win +                       M`tMinimize Inactive Windows", "WIN_TrayMenuMinimizeInactive")
	TRY_AddMenuItem("Windows", "           Win +                       End`tMinimize to Tray", "WIN_TrayMenuMinimizeToTray", "explorer.exe", 6)
	TRY_AddMenuItem("Windows", "                                             MiddleClick  on  Minimize`tMinimize to Tray", "WIN_TrayMenuMinimizeToTray", "explorer.exe", 6)
	TRY_AddMenuItem("Windows", "                                             RightClick    on  Minimize`tMinimize to Tray", "WIN_TrayMenuMinimizeToTray", "explorer.exe", 6)
	TRY_AddMenuItem("Windows")
	TRY_AddMenuItem("Windows")
	TRY_AddMenuItem("Windows", "           Win +                       LeftClick`tAlways on Top", "WIN_TrayMenuAlwaysOnTopToggle")
	TRY_AddMenuItem("Windows", "           Win +                       Wheel`tTransparency")
	TRY_AddMenuItem("Windows", "           Win + AltGr +         Wheel`tBrightness")
	TRY_AddMenuItem("Windows", "Ctrl + Win +                       Wheel`tPriority")
	TRY_AddMenuItem("Windows", "           Win +                       Pause`tSuspend", "SYS_TrayMenuSuspendProcess")
	TRY_AddMenuItem("Windows", "           Win + Shift +          Pause`tResume", "SYS_TrayMenuResumeProcess")
	TRY_AddMenuItem("Windows", "           RightClick +            Wheel`tAlt-Tab Switch")
	TRY_AddMenuItem("Windows", "           RightClick +            LeftClick`tRoll / Minimize", "WIN_TrayMenuRollToggle")
	TRY_AddMenuItem("Windows")
	TRY_AddMenuItem("Windows", "Ctrl +                                  MiddleClick`tClose Inside", "WIN_TrayMenuCloseInside")
	TRY_AddMenuItem("Windows", "                       Alt +             MiddleClick`tClose", "WIN_TrayMenuClose")
	TRY_AddMenuItem("Windows", "                                             MiddleClick  on  TitleBar`tClose", "WIN_TrayMenuClose")
	TRY_AddMenuItem("Windows", "                                             MiddleClick  on  Close`tKill", "WIN_TrayMenuKill")
	TRY_AddMenuItem("Windows", "           Win +                       MiddleClick`tKill", "WIN_TrayMenuKill")
	TRY_AddMenuItem("Windows", "           Win +                       F4`tKill", "WIN_TrayMenuKill")
	TRY_AddMenuItem("Windows")
	TRY_AddMenuItem("Windows", "                       Alt +             Wheel`tResize", "WIN_TrayMenuResize")
	TRY_AddMenuItem("Windows", "                                             RightDrag`tResize or Move", "WIN_TrayMenuResize")
	TRY_AddMenuItem("Windows", "Ctrl +                                   RightDrag`tForced Resize or Move", "WIN_TrayMenuResize")
	TRY_AddMenuItem("Windows", "                       Alt +             RightDrag`tResize proportionnally", "WIN_TrayMenuResize")
	TRY_AddMenuItem("Windows", "           Win +                       RightDrag`tCentered Resize", "WIN_TrayMenuResize")
	TRY_AddMenuItem("Windows", "                                Shift + RightDrag`tResize or Move by steps", "WIN_TrayMenuResize")
	TRY_AddMenuItem("Windows")
	TRY_AddMenuItem("Windows", "           Win +                        Numpad±`tCentered Resize proportionally", "WIN_TrayMenuResize")
	TRY_AddMenuItem("Windows", "           Win + Alt +              Numpad±`tResize proportionnally", "WIN_TrayMenuResize")

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	; System :
	;;;;;;;;;;

	TRY_AddMenuItem("System", "Ctrl +             Shift + Escape`t&Task Manager", "APP_TaskManager")
	TRY_AddMenuItem("System", "Ctrl + Win + Shift + Delete`t&Empty Recyle Bin", "APP_EmptyRecycleBin", "shell32.dll", 32)
	TRY_AddMenuItem("System", "Ctrl + Win +              Delete`t&Remove Programs", "APP_RemovePrograms", "shell32.dll", 163)
	TRY_AddMenuItem("System", "           Win + Shift + H`tRescan &Hardware", "APP_RescanHardware", "deskadp.dll")
	TRY_AddMenuItem("System")
	TRY_AddMenuItem("System", "Ctrl + Win +              F6`tShow/Hide &Hidden Files", "SYS_HiddenFiles")
	TRY_AddMenuItem("System", "Ctrl + Win + Shift + F6`tShow/Hide &System Files", "SYS_SystemFiles")
	TRY_AddMenuItem("System")
	TRY_AddMenuItem("System", "Ctrl + Win +              A`t&Administration", "APP_Administration", "shell32.dll", 43)
	TRY_AddMenuItem("System", "Ctrl + Win +              D`t&Disks", "APP_Disks", "shell32.dll", 8)
	TRY_AddMenuItem("System", "Ctrl + Win +              E`t&Explorer", "APP_Explorer", "explorer.exe", 2)
	TRY_AddMenuItem("System", "Ctrl + Win +              G`t&Group Policy", "APP_GroupPolicy")
	TRY_AddMenuItem("System", "Ctrl + Win +              H`t&Hardware", "APP_Hardware", "shell32.dll", 13)
	TRY_AddMenuItem("System", "Ctrl + Win +              P`t&Performances", "APP_Performances")
	TRY_AddMenuItem("System", "           Win +              R`t&Console", "APP_Console", A_ScriptDir . "\bin\Console.exe", , "cmd.exe")
	If (APP_CygWinPath) {
		TRY_AddMenuItem("System", "   Alt + Win +              R`t&CygWin", "APP_CygWin", APP_CygWinPath, , "cmd.exe")
	}
	If (APP_RegistryManagerPath) {
		TRY_AddMenuItem("System", "Ctrl + Win +              R`t&Registry", "APP_Registry", APP_RegistryManagerPath, , "regedit.exe")
	}
	If (APP_StartupDelayerPath) {
		TRY_AddMenuItem("System", "           Win +              S`t&Startup Delayer", "APP_StartupDelayer", APP_StartupDelayerPath)
	}
	TRY_AddMenuItem("System", "Ctrl + Win +              S`t&Services", "APP_Services")
	TRY_AddMenuItem("System", "Ctrl + Win +              T`t&Tasks", "APP_Tasks")
	TRY_AddMenuItem("System", "Ctrl + Win +              V`tE&vents", "APP_Events", "eventvwr.exe")
	TRY_AddMenuItem("System", "Ctrl + Win +              W`t&Windows Update", "SYS_WindowsUpdate")
	TRY_AddMenuItem("System", "Ctrl + Win +              Z`t&Rotate wallpaper", "SCR_ChangeWallpaper")

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	; Applications :
	;;;;;;;;;;;;;;;;

	If (APP_SnagItPath) {
		TRY_AddMenuItem("Applications", "           Win +           BackSpace`t&Snag It", "APP_SnagIt", APP_SnagItPath)
	}
	If (APP_MP3EditorPath) {
		TRY_AddMenuItem("Applications", "Ctrl + Win +           BackSpace`t&MP3 Editor", "APP_MP3Editor", APP_MP3EditorPath)
	}
	If (APP_PhotoshopPath) {
		TRY_AddMenuItem("Applications", "Ctrl + Win + Alt + BackSpace`t&Photoshop", "APP_Photoshop", APP_PhotoshopPath)
	}
	If (APP_BashPath) {
		TRY_AddMenuItem("Applications", "           Win +           B`t&Bash", "APP_Bash", APP_BashPath)
	} Else {
		HotKey, #b, Off
	}
	TRY_AddMenuItem("Applications", "           Win +           C`t&Calculator", "APP_Calculator", "system32\calc.exe")
	If (APP_DirectoryOpusPath) {
		TRY_AddMenuItem("Applications", " Alt + Win +           E`tDirectory &Opus", "APP_DOpus", APP_DirectoryOpusPath)
	} Else {
		TRY_AddMenuItem("Applications", "           Win +           E`t&Explorer", "APP_DOpus", "explorer.exe")
	}
	If (APP_FirefoxPath) {
		TRY_AddMenuItem("Applications", "           Win +           I`t&Firefox", "APP_TrayMenuFirefox", APP_FirefoxPath)
	}
	If (APP_InternetExplorerPath) {
		TRY_AddMenuItem("Applications", " Alt + Win +           I`t&IE", "APP_TrayMenuIE", APP_InternetExplorerPath)
	}
	If (APP_EclipsePath) {
		TRY_AddMenuItem("Applications", "           Win +           J`t&JMP", "APP_JMP", APP_EclipsePath)
	}
	TRY_AddMenuItem("Applications", "           Win +           K`t&KGS", "APP_KGS")
	If (APP_MediaMonkeyPath) {
		TRY_AddMenuItem("Applications", "           Win +           M`t&Media Monkey", "APP_MediaMonkey", APP_MediaMonkeyPath)
	}
	TRY_AddMenuItem("Applications", "           Win +           N`tSticky &Notes", "APP_Notes", "StikyNot.exe")
	If (FileExist(ZZZ_ProgramFiles32 . "\PuTTY Connection Manager\puttycm.exe")) {
		TRY_AddMenuItem("Applications", "           Win +           P`t&PuTTY", "APP_PuTTY", "PuTTY Connection Manager\puttycm.exe")
	}
	If (APP_SQLDeveloperPath) {
		TRY_AddMenuItem("Applications", "           Win +           Q`tS&QL Developer", "APP_SQL", APP_SQLDeveloperPath)
	} Else If (APP_QuintessentialPath) {
		TRY_AddMenuItem("Applications", "           Win +           Q`t&Quintessential", "APP_SQL", APP_QuintessentialPath)
	} Else {
		HotKey, #q, Off
	}
	If (APP_MailApplicationPath) {
		TRY_AddMenuItem("Applications", "           Win +           T`t&Mail", "APP_TrayMenuMail", APP_MailApplicationPath)
	} Else {
		HotKey, #t, Off
		HotKey, +#t, Off
	}
	If (APP_TextEditorPath) {
		TRY_AddMenuItem("Applications", "           Win +           U`t&Text Editor", "APP_UltraEdit", APP_TextEditorPath)
	} Else {
		Hotkey, #u, Off
	}
	If (APP_uTorrentPath) {
		TRY_AddMenuItem("Applications", "           Win +           µ`t&µTorrent", "APP_muTorrent", APP_uTorrentPath)
	} Else {
		Hotkey, #SC02B, Off
		Hotkey, +#SC02B, Off

	}
	If (APP_VideoConverterPath) {
		TRY_AddMenuItem("Applications", "           Win +           V`t&Video Converter", "APP_Video", APP_VideoConverterPath)
	}
	If (APP_WindowsMediaPlayerPath) {
		TRY_AddMenuItem("Applications", "           Win +           W`t&WMP", "APP_WMP", APP_WindowsMediaPlayerPath)
	}

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	; Administration :
	;;;;;;;;;;;;;;;;;;

	TRY_AddMenuItem("Administration", "Ctrl + Win +              Escape`t&Cancel Visual Effects", "WIN_CancelVisualEffects")
	TRY_AddMenuItem("Administration", "Ctrl + Win + Shift + S`tWindow&Spy", "ADM_TrayMenuWindowSpy", "AutoHotkey\AU3_Spy.exe")
	
	If (APP_WinSpectorPath) {
		TRY_AddMenuItem("Administration", "Ctrl + Win + Shift + X`tWinS&pector", "ADM_WinSpector", APP_WinSpectorPath)
	}
	If (APP_AutoScriptWriterPath) {
		TRY_AddMenuItem("Administration", "Ctrl + Win + Shift + R`tRe&corder", "ADM_Recorder", APP_AutoScriptWriterPath)
	}
	TRY_AddMenuItem("Administration")
	If (APP_SciTEPath) {
		TRY_AddMenuItem("Administration", "Ctrl + Win + Shift + E`t&Edit", "ADM_Edit", APP_SciTEPath, , APP_SciTEPath)
	}
	TRY_AddMenuItem("Administration", "Ctrl + Win + Shift + D`t&Debug", "ADM_Debug") ; TODO : "drwatson.exe")
	TRY_AddMenuItem("Administration", "Ctrl + Win + Shift + K`tL&ock Keyboard", "KBD_LockManager")
	TRY_AddMenuItem("Administration", "Ctrl + Win + Shift + Escape`t&Suspend", "AHK_ToggleSuspend", "shell32.dll", 110)
	TRY_AddMenuItem("Administration", "Ctrl + Win + Shift + F4`tE&xit", "AHK_Exit")
	TRY_AddMenuItem("Administration", "Ctrl + Win +              F5`tReset &Control Keys", "AHK_ResetControlKeys")
	TRY_AddMenuItem("Administration", "Ctrl + Win + Shift + F5`t&Reload", "ADM_Reload", "shell32.dll", 147)
	TRY_AddMenuItem("Administration")
	TRY_AddMenuItem("Administration", "           Win +              F1`t&Memo", "ADM_Memo", "shell32.dll", 115)
	TRY_AddMenuItem("Administration", "Ctrl + Win +              F1`t&Help", "ADM_Help", "hh.exe")
	TRY_AddMenuItem("Administration", "Ctrl + Win + Shift + F1`t&About", "ADM_About", "shell32.dll", 24)
	TRY_AddMenuItem("Administration", "Ctrl + Win + Shift + W`tVisit &Website", "ADM_Website", "shell32.dll", 14)

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	; Options :
	;;;;;;;;;;;
	SysGet, AHK_MouseButtonNumber, 43
	TRY_AddMenuItem("Options", "Ctrl + Win + Shift + F`tX-Mouse &Focus", "WIN_ToggleFocusFollowsMouse")
	TRY_AddMenuItem("Options", "Ctrl + Win + Shift + Z`tWallpaper &Rotation", "SCR_ToggleWallpaperRotation")
	If (AHK_MouseButtonNumber > 0) {
		TRY_AddMenuItem("Options")
		TRY_AddMenuItem("Options", "Ctrl + Win + Shift + 0`tMouse &Traces", "AHK_ToggleMouseTraces")
		TRY_AddMenuItem("Options", "Ctrl + Win + Shift + 1`t&Left Mouse Button", "AHK_ToggleLeftMouseButton")
		If (AHK_MouseButtonNumber >= 2) {
			TRY_AddMenuItem("Options", "Ctrl + Win + Shift + 2`t&Middle Mouse Button", "AHK_ToggleMiddleMouseButton")
		}
		If (AHK_MouseButtonNumber >= 3) {
			TRY_AddMenuItem("Options", "Ctrl + Win + Shift + 3`t&Right Mouse Button", "AHK_ToggleRightMouseButton")
		}
		If (AHK_MouseButtonNumber >= 4) {
			TRY_AddMenuItem("Options", "Ctrl + Win + Shift + 4`t&4th Mouse Button", "AHK_Toggle4thMouseButton")
		}
		If (AHK_MouseButtonNumber >= 5) {
			TRY_AddMenuItem("Options", "Ctrl + Win + Shift + 5`t&5th Mouse Button", "AHK_Toggle5thMouseButton")
		}
		TRY_AddMenuItem("Options")
	}
	TRY_AddMenuItem("Options", "Ctrl + Win + Shift + A`t&Audio", "AHK_ToggleAudio")
	TRY_AddMenuItem("Options", "Ctrl + Win + Shift + B`t&Balloon Messages", "AHK_ToggleTrayTip")
	TRY_AddMenuItem("Options", "Ctrl + Win + Shift + G`tLo&gs", "AHK_ToggleLogs")
	TRY_AddMenuItem("Options", "Ctrl + Win + Shift + O`t&Debug", "AHK_ToggleDebug")
	TRY_AddMenuItem("Options", "Ctrl + Win + Shift + Q`tTray &Icon", "TRY_ToggleTrayIcon", "rasdlg.dll", 2)
	TRY_AddMenuItem("Options", "Ctrl + Win + Shift + T`t&Tooltips", "AHK_ToggleToolTip")

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	; Tray menu :
	;;;;;;;;;;;;;

	Menu, Tray, NoStandard
	Menu, Tray, UseErrorLevel
	TRY_AddMenu("Tray", "&Locutions", "Gray")
	, TRY_AddMenu("Tray", "&Subordonates", "Gray")
	, TRY_AddMenu("Tray", "&Verbs", "Gray")
	, TRY_AddMenu("Tray", "&Adverbs", "Gray")
	, TRY_AddMenu("Tray", "&Positions", "Gray")
	, TRY_AddMenu("Tray")
	, TRY_AddMenu("Tray", "&Pronuns", "Gray")
	, TRY_AddMenu("Tray", "&Some", "Gray")
	, TRY_AddMenu("Tray", "&Adjectives", "Gray")
	, TRY_AddMenu("Tray")
	, TRY_AddMenu("Tray", "&Things", "Gray")
	, TRY_AddMenu("Tray", "&Actions", "Gray")
	, TRY_AddMenu("Tray", "&Computing", "Gray")
	, TRY_AddMenu("Tray")
	, TRY_AddMenu("Tray", "&Time", "Gray")
	, TRY_AddMenu("Tray", "&Various", "Gray")
	, TRY_AddMenu("Tray", "&Suffixes", "Gray")
	, TRY_AddMenu("Tray")
	, TRY_AddMenu("Tray")
	, TRY_AddMenu("Tray", "&Login", , "Pale Moon\palemoon.exe", 5)
	, TRY_AddMenu("Tray", "&Case", , "pifmgr.dll", 3)
	, TRY_AddMenu("Tray", "&ClipBoard", , "clipbrd.exe", 2)
	, TRY_AddMenu("Tray")
	, TRY_AddMenu("Tray", "&Audio", , "shell32.dll", 169)
	, TRY_AddMenu("Tray", "&Power", , "powercfg.cpl", 5)
	, TRY_AddMenu("Tray", "&Screen", , "shell32.dll", 140)
	, TRY_AddMenu("Tray", "&Windows", , "shell32.dll", 141)
	, TRY_AddMenu("Tray", "&System", , "moricons.dll", 114)
	, TRY_AddMenu("Tray", "&Applications", , "shell32.dll", 25)
	, TRY_AddMenu("Tray")
	, TRY_AddMenu("Tray", "&Administration        ", , "shell32.dll", 170)
	, TRY_AddMenu("Tray", "&Options", , "shell32.dll", 36)

	, TRY_AddMenuItem("Tray", "&Suspend", "AHK_ToggleSuspend", "shell32.dll", 110)
	, TRY_AddMenuItem("Tray", "E&xit", "AHK_Exit", "shell32.dll", 132)
	Menu, Tray, Color, Silver, Single
	Menu, Tray, Default, &Suspend
	Menu, Tray, Tip, %AHK_ScriptInfo%

	TRY_UpdateMenus()
	, AHK_Log("< TRY_InitMenus()")
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Manage menus :
;;;;;;;;;;;;;;;;

TRY_AddMenu(PRM_Menu, PRM_SubMenu = "", PRM_Color = "", PRM_IconFile1 = "", PRM_IconNumber1 = 1, PRM_IconFile2 = "", PRM_IconNumber2 = 1, PRM_IconFile3 = "", PRM_IconNumber3 = 1) {

	Global ZZZ_ProgramFiles32, ZZZ_ProgramFiles64
	If (PRM_SubMenu == "") {
		Menu, %PRM_Menu%, Add
		Return
	}
	StringReplace, LOC_SubMenu, PRM_SubMenu, &, , All
	StringReplace, LOC_SubMenu, LOC_SubMenu, % " ", , All
	StringReplace, LOC_SubMenu, LOC_SubMenu, % " ", , All
	Menu, %PRM_Menu%, Add, %PRM_SubMenu%, :%LOC_SubMenu%
	If (PRM_Color) {
		Try {
			Menu, %PRM_Menu%, Color, %PRM_Color%
		}
	}

	LOC_Break := false
	Loop, 3
	{
		If (LOC_Break) {
			Break
		}
		LOC_IconFile := "PRM_IconFile" . A_Index
		LOC_IconFile := %LOC_IconFile%
		LOC_IconNumber := "PRM_IconNumber" . A_Index
		LOC_IconNumber := %LOC_IconNumber%
		If (LOC_IconFile != "") {
			LOC_DirectoryPrefixes := "|" . ZZZ_ProgramFiles32 . "\|" . ZZZ_ProgramFiles64 . "\|" . A_WinDir . "\|" . A_WinDir . "\system32\"
			Loop, Parse, LOC_DirectoryPrefixes, |
			{
				If (FileExist(A_LoopField . LOC_IconFile)) {
					Try {
						Menu, %PRM_Menu%, Icon, %PRM_SubMenu%, %A_LoopField%%LOC_IconFile%, %LOC_IconNumber%, 16
					} Catch LOC_Exception {
						AHK_Catch(LOC_Exception, "TRY_AddMenu", PRM_Menu, PRM_SubMenu, LOC_IconFile, LOC_IconNumber)
						Continue
					}
					LOC_Break := true
					Break
				}
			}
		}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TRY_AddMenuItem(PRM_Menu, PRM_MenuItem = "", PRM_Action = false, PRM_IconFile1 = "", PRM_IconNumber1 = 1, PRM_IconFile2 = "", PRM_IconNumber2 = 1, PRM_IconFile3 = "", PRM_IconNumber3 = 1) {

	Global ZZZ_ProgramFiles32, ZZZ_ProgramFiles64
	If (PRM_MenuItem == "") {
		Menu, %PRM_Menu%, Add
		Return
	}
	Menu, %PRM_Menu%, Add, %PRM_MenuItem%, % (PRM_Action ? PRM_Action : "AHK_DoNothing")
	If (!PRM_Action) {
		Menu, %PRM_Menu%, Disable, %PRM_MenuItem%
	}
	LOC_Break := false
	LOC_DirectoryPrefixes := "|" . ZZZ_ProgramFiles32 . "\|" . ZZZ_ProgramFiles64 . "\|" . A_WinDir . "\|" . A_WinDir . "\system32\"
	Loop, 3 {
		LOC_IconFile := PRM_IconFile%A_Index%
		LOC_IconNumber := PRM_IconNumber%A_Index%
		If (LOC_IconFile != "") {
			Loop, Parse, LOC_DirectoryPrefixes, |
			{
				If (FileExist(A_LoopField . LOC_IconFile)) {
					Try {
						Menu, %PRM_Menu%, Icon, %PRM_MenuItem%, %A_LoopField%%LOC_IconFile%, %LOC_IconNumber%, 16
						LOC_Break := true
						Break
					}
				}
			}
			If (LOC_Break) {
				Break
			}
		}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TRY_UpdateMenus() {

	Global
	Local PRM_Checked
	TRY_SetCheckIcon("Options", "Ctrl + Win + Shift + F`tX-Mouse &Focus", PRM_Checked := WIN_FocusFollowsMouseEnabled)
	TRY_SetCheckIcon("Options", "Ctrl + Win + Shift + Z`tWallpaper &Rotation", PRM_Checked := SCR_WallpaperRotationEnabled)
	If (AHK_MouseButtonNumber >= 1) {
		TRY_SetCheckIcon("Options", "Ctrl + Win + Shift + 0`tMouse &Traces", PRM_Checked := SCR_MouseTracesEnabled)
		TRY_SetCheckIcon("Options", "Ctrl + Win + Shift + 1`t&Left Mouse Button", PRM_Checked := AHK_LeftMouseButtonHookEnabled)
	}
	If (AHK_MouseButtonNumber >= 2) {
		TRY_SetCheckIcon("Options", "Ctrl + Win + Shift + 2`t&Middle Mouse Button", PRM_Checked := AHK_MiddleMouseButtonHookEnabled)
	}
	If (AHK_MouseButtonNumber >= 3) {
		TRY_SetCheckIcon("Options", "Ctrl + Win + Shift + 3`t&Right Mouse Button", PRM_Checked := AHK_RightMouseButtonHookEnabled)
	}
	If (AHK_MouseButtonNumber >= 4) {
		TRY_SetCheckIcon("Options", "Ctrl + Win + Shift + 4`t&4th Mouse Button", PRM_Checked := AHK_FourthMouseButtonHookEnabled)
	}
	If (AHK_MouseButtonNumber >= 5) {
		TRY_SetCheckIcon("Options", "Ctrl + Win + Shift + 5`t&5th Mouse Button", PRM_Checked := AHK_FifthMouseButtonHookEnabled)
	}

	TRY_SetCheckIcon("Options", "Ctrl + Win + Shift + A`t&Audio", PRM_Checked := AHK_AudioEnabled)
	TRY_SetCheckIcon("Options", "Ctrl + Win + Shift + B`t&Balloon Messages", PRM_Checked := TRY_TrayTipEnabled)
	TRY_SetCheckIcon("Options", "Ctrl + Win + Shift + G`tLo&gs", PRM_Checked := AHK_LogsEnabled)
	TRY_SetCheckIcon("Options", "Ctrl + Win + Shift + O`t&Debug", PRM_Checked := AHK_DebugEnabled)
	TRY_SetCheckIcon("Options", "Ctrl + Win + Shift + T`t&ToolTips", PRM_Checked := AHK_ToolTipsEnabled)
	TRY_SetCheckIcon("Options", "Ctrl + Win + Shift + Q`tTray &Icon", PRM_Checked := !ZZZ_TrayIconHidden)


	If (AHK_Suspended) {
		Menu, Tray, Rename, &Suspend, &Resume
		Menu, Administration, Rename, Ctrl + Win + Shift + Escape`t&Suspend, Ctrl + Win + Shift + Escape`t&Resume
	} Else {
		Menu, Tray, Rename, &Resume, &Suspend
		Menu, Administration, Rename, Ctrl + Win + Shift + Escape`t&Resume, Ctrl + Win + Shift + Escape`t&Suspend
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TRY_AddMenuSeparator(PRM_Menu, PRM_Separator = "–", PRM_FirstLength = false, PRM_SecondLength = false) {

	Static STA_Menu = false, STA_FirstLength = 32, STA_SecondLength = 32, STA_SpaceCount = 0

	If (PRM_FirstLength) {
		STA_FirstLength := PRM_FirstLength
	}
	If (PRM_SecondLength) {
		STA_SecondLength := PRM_SecondLength
	}
	If (PRM_Menu == STA_Menu) {
		STA_SpaceCount++
	} Else {
		STA_Menu := PRM_Menu
		, STA_SpaceCount := 0
		, STA_FirstLength := (PRM_FirstLength ? PRM_FirstLength : 32)
		, STA_SecondLength := (PRM_SecondLength ? PRM_SecondLength : 32)
	}

	LOC_Separator := ""
	Loop, %STA_FirstLength% {
		LOC_Separator .= PRM_Separator
	}
	LOC_Separator .= "`t"
	Loop, %STA_SecondLength% {
		LOC_Separator .= PRM_Separator
	}
	Loop, %STA_SpaceCount% {
		LOC_Separator .= " "
	}
	Menu, %PRM_Menu%, Add, %LOC_Separator%, AHK_DoNothing
	Menu, %PRM_Menu%, Disable, %LOC_Separator%
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Hostring actions :
;;;;;;;;;;;;;;;;;;;;

TRY_TrayMenuHotstring:
TRY_Hotstring()
Return

TRY_Hotstring() {
	StringGetPos, LOC_Hotstring, A_ThisMenuItem, `t
	LOC_Hotstring := SubStr(A_ThisMenuItem, LOC_Hotstring + 2)
	, WIN_FocusLastWindow()
	TXT_SendRaw(LOC_Hotstring)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Tray icon :
;;;;;;;;;;;;;

TRY_SetCheckIcon(PRM_Menu, PRM_MenuItem, PRM_Checked = true) {

	Global
	If (FileExist(A_WinDir . "\system32\rasdlg.dll")) {
		If (PRM_Checked) {
			Menu, %PRM_Menu%, Icon, %PRM_MenuItem%, %A_WinDir%\system32\rasdlg.dll, 1
		} Else {
			Menu, %PRM_Menu%, Icon, %PRM_MenuItem%, %A_WinDir%\system32\rasdlg.dll, 2
		}
	} Else {
		If (PRM_Checked) {
			Menu, %PRM_Menu%, Check, %PRM_MenuItem%
		} Else {
			Menu, %PRM_Menu%, UnCheck, %PRM_MenuItem%
		}
	}
	If (ErrorLevel) {
		MsgBox, 48, %AHK_ScriptName%, An error occured while trying to perform a menu operation :`n`nMenu`t: '%PRM_Menu%'`nMenu item`t: '%PRM_MenuItem%' ; OK button
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

^+#q::
TRY_ToggleTrayIcon()
Return

TRY_ToggleTrayIcon:
TRY_ToggleTrayIcon()
Menu, Options, Show
Return

TRY_ToggleTrayIcon() {
	Global ZZZ_TrayIconHidden, ZZZ_CheckTrayIconStatePeriodicTimer
	ZZZ_TrayIconHidden := !ZZZ_TrayIconHidden
	If (ZZZ_TrayIconHidden) {
		TRY_ShowTrayTip("", 2)
		SetTimer, TRY_HideTrayTimer, -3000
	} Else {
		Menu, Tray, Icon
		SetTimer, TRY_CheckTrayIconStatePeriodicTimer, Off
		TRY_SetHotstringsTrayIcon(PRM_Tooltip := false)
		SetTimer, TRY_CheckTrayIconStatePeriodicTimer, %ZZZ_CheckTrayIconStateTimer%
		TRY_ShowTrayTip("Tray icon recovered`nCtrl + Win + Shift + Q to hide it")
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TRY_HideTrayTimer:
Menu, Tray, NoIcon
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TRY_CheckTrayIconStatePeriodicTimer:
TRY_SetHotstringsTrayIcon()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TRY_SetHotstringsTrayIcon(PRM_Tooltip = true) {

	Global ZZZ_TrayIconHidden, ZZZ_InactiveTrayIcon, ZZZ_NoHotstringsTrayIcon, ZZZ_ActiveTrayIcon
	Static STA_ShellNotifyIconFunction := AHK_GetFunction("shell32", "Shell_NotifyIcon"), STA_PreviousTrayState := -1 ; -1 : not defined / 0 : disabled / +1 : enabled / +2 : enabled + hotstrings

	LOC_CurrentTrayState := (ZZZ_TrayIconHidden
		? -1
		: (A_IsSuspended || WinActive("ahk_group WIN_SuspendingWindowsGroup")
			? 0
			: (WinActive("ahk_group HOT_IgnoringWindows")
				? (STA_PreviousTrayState == -1
					? 1
					: STA_PreviousTrayState)
				: (WinActive("ahk_group HOT_HotstringsWindowsGroup")
					? 2
					: 1))))

	If (LOC_CurrentTrayState != STA_PreviousTrayState) {
		If (LOC_CurrentTrayState == 0) {
			DllCall(STA_ShellNotifyIconFunction, "UInt", 0x1, "UInt", &ZZZ_InactiveTrayIcon)
		} Else If (LOC_CurrentTrayState == 1) {
			If (PRM_Tooltip) {
				TRY_ShowTrayTip("Hotstrings disabled")
			}
			DllCall(STA_ShellNotifyIconFunction, "UInt", 0x1, "UInt", &ZZZ_NoHotstringsTrayIcon)
		} Else If (LOC_CurrentTrayState == 2) {
			If (PRM_Tooltip) {
				TRY_ShowTrayTip("Hotstrings enabled")
			}
			DllCall(STA_ShellNotifyIconFunction, "UInt", 0x1, "UInt", &ZZZ_ActiveTrayIcon)
		}
		TRY_UpdateMenus()
	}
	STA_PreviousTrayState := LOC_CurrentTrayState
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TRY_InitTrayIcon() {

	Global
	Local LOC_HexaIcon, LOC_IconSize, LOC_TrayIconHandle, LOC_CurrentWindowID
	AHK_Log("> TRY_InitTrayIcon()")

	ZZZ_TrayIconHidden := false
	LOC_HexaIcon =
	( LTrim Join
		0000010001001010000001002000680400001600000028000000100000002000
		0000010020000000000040040000000000000000000000000000000000000000
		0000000000000000000000000000000000000000000000000000000000000000
		0000000000000000000000000000000000000000000000000000000000000000
		0000000000000000000000000000000000020000000000000000000000000000
		000000000000000000003E3C3A104B4946CE4D4B48E8403F3C68000000000000
		0000000000000000000042403D5C4F4D4AEA4B4946D4403F3C37000000000000
		00000000000000000000464441935C5A56FF8C8981FF54524FFC3F3E3B5F0000
		0000000000004543407052504DFA5D5A54FF56544FFF514F4CFC464442A10000
		00093837355C413F3C554E4C49E1726F6AFFA8A49BFF565450FD3F3E3B5C0000
		000044423F7A565451FA898579FF58564EFF535049FF6C6A63FF5F5D59FF413F
		3DB552504CFA555350FE4B4A46F5908D83FF7F7C74FF4E4C49E3000000044341
		3F8B5A5855FCAFACA4FF918E80FF5B5951FF54524CFF6B6963FF939085FFACAA
		A0FF6B6862FF9C9A8DFF737167FF9A998DFF5C5B57FF403F3C83000000005351
		4EF9A9A7A0FFB2B1A7FF939184FF979289FFA19E96FF807E77FF8D897FFFB0AF
		A6FF6B6760FF8C877AFF7F7C70FF908E81FF686762FB4D4B48E944423F905351
		4EF3A09F9AFFB7B7AEFFB5B2ABFFCDC9C2FFD8DBD0FFBFBAB7FFAEACA6FFB9B6
		AFFF76726BFF968F82FF817D71FF7C796CFF8A8779FE6E6C66FF484643C34C4A
		47D2908F8AFFCFCDC8FFB7B6AEFFAEABA4FFB0AEA4FFAAAAA0FFBCBDB4FFC9C9
		C3FF847F75FF9C998FFF908D7FFF8E8A79FF807D75FF504E4BE93E3C3A164846
		43A26E6C69FF9E9A91FFAAA99EFFAAA8A0FFA7A79DFFA8A89DFFA9A89EFFABA8
		A1FF838179FDADAAA2FFA49F96FFA09D94FF53514EFC3C3B3831000000004442
		3F284E4C48C752504DF85E5C58FF848177FF98968AFF8F8B80FF605E5AFF4E4C
		48A6615F5BE2AEABA5FFC5C1B9FF62605CFC42403E8700000000000000000000
		0000000000004A48442E4847438A514F4CF45A5854FF53514DFC4846439B0000
		000653514EF0C0C0BCFF878581FF4C4A47C80000000000000000000000000000
		00000000000000000000000000004846420C4B49458B4846423E000000000000
		0005555350F4B0AFACFF53514EEF000000060000000000000000000000000000
		0000000000000000000000000000000000000000000000000000000000000000
		00024E4C49DE555350FA403E3B4D000000000000000000000000000000000000
		0000000000000000000000000000000000000000000000000000000000000000
		0000000000000000000000000000000000000000000000000000000000000000
		0000000000000000000000000000000000000000000000000000000000000000
		000000000000000000000000000000000000000000000000000000000000FFFF
		FF00FFE1FF00E1E0FF00C080FF008001FF000001000700000D8300005DFA0000
		6EFF000160FF000363FFC08760FFF18F40E8FF8F0E88FFFF001DFFFF0470
	)
	VarSetCapacity(ZZZ_ActiveTrayIcon, (LOC_IconSize := StrLen(LOC_HexaIcon) // 2))
	Loop, %LOC_IconSize% { ; MCode by Laszlo Hars: http://www.autohotkey.com/forum/viewtopic.php?t=21172
		NumPut("0x" . SubStr(LOC_HexaIcon, 2 * A_Index - 1, 2), ZZZ_ActiveTrayIcon, A_Index - 1, "Char")
	}
	LOC_TrayIconHandle := DllCall("user32.dll\CreateIconFromResourceEx", "UInt", &ZZZ_ActiveTrayIcon + 22, "UInt", NumGet(ZZZ_ActiveTrayIcon, 14), "Int", 1, "UInt", 0x30000, "Int", 16, "Int", 16, "UInt", 0)
	SendMessage, 0x80, 0, LOC_TrayIconHandle ; Set the Titlebar Icon
	; SendMessage, 0x80, 1, LOC_TrayIconHandle ; Set the Alt-Tab icon - not used
	VarSetCapacity(ZZZ_ActiveTrayIcon, 444, 0), NumPut(444, ZZZ_ActiveTrayIcon)
	, LOC_CurrentWindowID := WinExist(A_ScriptFullPath . " ahk_class AutoHotkey ahk_pid " . AHK_AutoHotKeyPID)
	, NumPut(LOC_CurrentWindowID, ZZZ_ActiveTrayIcon, 4)
	, NumPut(1028, ZZZ_ActiveTrayIcon, 8), NumPut(2, ZZZ_ActiveTrayIcon, 12), NumPut(LOC_TrayIconHandle, ZZZ_ActiveTrayIcon, 20)


	LOC_HexaIcon =
	( LTrim Join
		0000010001001010000001002000680400001600000028000000100000002000
		0000010020000000000040040000000000000000000000000000000000000000
		0000000000000000000000000000000000000000000000000000000000000000
		0000000000000000000000000000000000000000000000000000000000000000
		0000000000000000000000000000000000020000000000000000000000000000
		0000000000000000000072706C107F7D78CE817F7AE874736E68000000000000
		0000000000000000000076746F5C83817CEA7F7D78D474736E37000000000000
		000000000000000000007A787393908E88FFBCBBB7FF888681FC73726D5F0000
		0000000000007977727086847FFA928E85FF8B8880FF85837EFC7A7874A10000
		00096C6B675C75736E5582807BE1A5A29DFFD8D6D1FF8A8882FD73726D5C0000
		00007876717A8A8883FAB9B7AFFF8D8A7FFF898479FF9F9D96FF92908CFF7773
		6DB586847EFA898782FE817E76F5C0BFB9FFB0AEA9FF82807BE3000000047775
		718B8E8C87FCDFDEDAFFC1BEB6FF908E82FF89867DFF9E9C96FFC3C2BBFFDCDA
		D6FF9E9B95FFCCCAC3FFA5A49BFFCAC9C3FF8F8E8AFF74736E83000000008785
		80F9D9D9D6FFE2E1DDFFC3C1BAFFC7C4BFFFD1D0CCFFB2B0ABFFBDBBB5FFE0DF
		DCFF9E9A93FFBCB9B0FFB0AEA5FFC0BEB7FF9B9A95FB817F7AE9787671908785
		80F3D2D1CEFFE7E7E4FFE5E4E1FFFBFBFAFFFFFFFFFFEFEEEDFFDEDEDCFFE9E8
		E5FFA8A59FFFC4C1BAFFB2AFA6FFADAAA1FFBAB7AFFEA19F99FF7C7A75C3807E
		79D2C2C1BEFFFFFFFEFFE7E7E4FFDEDDDAFFE0DEDAFFDADAD6FFECEDEAFFF9F9
		F9FFB4B1ABFFCCCBC5FFC0BDB5FFBCBAB1FFB1AFAAFF84827DE972706C167C7A
		75A2A19F9CFFCECCC7FFDAD9D4FFDADAD6FFD7D7D3FFD8D8D3FFD9D8D4FFDBDA
		D7FFB4B3AEFDDDDCD8FFD4D1CCFFD0CFCAFF878580FC706F6A31000000007876
		712882807AC786847FF8918F8BFFB4B3ADFFC8C6C0FFBFBDB6FF93918DFF8280
		7AA694928EE2DEDDDBFFF3F3F1FF95938FFC7674708700000000000000000000
		0000000000007E7C762E7C7B758A85837EF48E8C86FF87857FFC7C7A759B0000
		0006878580F0F2F2F0FFB9B7B5FF807E79C80000000000000000000000000000
		00000000000000000000000000007C7A740C7F7D778B7C7A743E000000000000
		0005898782F4E2E1E0FF878580EF000000060000000000000000000000000000
		0000000000000000000000000000000000000000000000000000000000000000
		000282807BDE898782FA74706D4D000000000000000000000000000000000000
		0000000000000000000000000000000000000000000000000000000000000000
		0000000000000000000000000000000000000000000000000000000000000000
		0000000000000000000000000000000000000000000000000000000000000000
		000000000000000000000000000000000000000000000000000000000000FFFF
		FF00FFE1FF00E1E0FF00C080FF008001FF000001000700000D8300005DFA0000
		6EFF000160FF000363FFC08760FFF18F40E8FF8F0E88FFFF001DFFFF0470
	)
	VarSetCapacity(ZZZ_NoHotstringsTrayIcon, (LOC_IconSize := StrLen(LOC_HexaIcon) // 2))
	Loop, %LOC_IconSize% {
		NumPut("0x" . SubStr(LOC_HexaIcon, 2 * A_Index - 1, 2), ZZZ_NoHotstringsTrayIcon, A_Index - 1, "Char")
	}
	LOC_TrayIconHandle := DllCall("user32.dll\CreateIconFromResourceEx", "UInt", &ZZZ_NoHotstringsTrayIcon + 22, "UInt", NumGet(ZZZ_NoHotstringsTrayIcon, 14), "Int", 1, "UInt", 0x30000, "Int", 16, "Int", 16, "UInt", 0)
	, NumPut(LOC_CurrentWindowID, ZZZ_NoHotstringsTrayIcon, 4)
	, NumPut(1028, ZZZ_NoHotstringsTrayIcon, 8), NumPut(2, ZZZ_NoHotstringsTrayIcon, 12), NumPut(LOC_TrayIconHandle, ZZZ_NoHotstringsTrayIcon, 20)


	LOC_HexaIcon =
	( LTrim Join
		000001000100101000000100200068040000160000002800000010000000200000000100200000000000400400000000
		0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
		FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF006E6D
		6902FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0072706C107F7D78CE817F7AE874736E68FFFFFF00FFFF
		FF00FFFFFF00FFFFFF0076746F5C83817CEA3B466BEE091A4FE7051442EE051138E1031034B3020C294878767194908E
		88FFBCBBB7FF888681FC73726D5FFFFFFF00FFFFFF00797772707E7C7DFF122663FF1E3165FF4A5578FF3A4870CC0D1F
		5966343C548E1D2643B4353A49F5A09E99FFD8D6D1FF8A8882FD73726D5CFFFFFF007876717A8A8883FA11266BFF2D44
		7EFF385097FF888C96FF92908CFF77736DB5807F7CFB6C6E75FF51555EFD5B606DFFAAA9A4FF82807BE36D6C67047775
		718B8E8C87FC485FA2FF19317AFF485FA1FF3D549DFF2545A9FFA4A9B4FFDCDAD6FF9E9B95FFCCCAC3FF838689FF676D
		7EFF6D6F73FF71706C85FFFFFF00878580F9D9D9D6FF0F2A78FF4A64B9FFB5B7BFFFA6AFCAFF1B40B0FF1C3FADFFBCC1
		D0FF9E9A93FFBCB9B0FFA9A8A2FF8B8F9AFF3A4159FF797774EB78767190878580F3D2D1CEFF0D2774FF2F58D7FFFBFB
		FAFFFFFFFFFFBCC6E4FF1D42B2FF1E42B0FF8E919EFFC4C1BAFFB2AFA6FF707587FF232E52FF91908CFF7C7A75C3807E
		79D2C2C1BEFF0E297CFF2A56DCFFDEDDDAFFE0DEDAFFDADAD6FFBAC5E1FF1E44B4FF1B3FABFFABB0BDFFC0BDB5FF6C76
		93FF192754FF727270EC72706C167C7A75A2A19F9CFF102F8CFF4568CCFFC4C9D6FFD7D7D3FFD8D8D3FFD9D8D4FFAEB6
		D3FF1B40B0FF2D4EB3FFB5B7C4FF7783A8FF1C2C5BFF47495047FFFFFF007876712882807AC72444A3FF133393FF4669
		D1FFC8C6C0FFBFBDB6FF93918DFF82807AA6727C9BEA5A73C0FF5972BFFF233671FF25355FCE050E2B0AFFFFFF00FFFF
		FF00FFFFFF007E7C762E113196FF1E3EA1FF3B5DC5FF797D89FD7C7A759B68655F067A7D87F27189D1FF405595FF0C21
		61FF06133924FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00133DC01F103196FF0F2F90FE1A41BAD71646DAE91645
		D4E23352A8FF1E3785FF0F2469FF0F21583EFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
		FF001037AAD40E2E8CFF0E297CFF0D2774FF0E2775FF2B4082FF64636957FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
		FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
		FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
		FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7E1FF00E000FF00C000FF008000
		FF000001000700000D8300005DFA00006EFF000160FF000163FFC00360FFE00740E8F80F0E88FFFF001DFFFF0470
	)
	VarSetCapacity(ZZZ_InactiveTrayIcon, (LOC_IconSize := StrLen(LOC_HexaIcon) // 2))
	Loop, %LOC_IconSize% {
		NumPut("0x" . SubStr(LOC_HexaIcon, 2 * A_Index - 1, 2), ZZZ_InactiveTrayIcon, A_Index - 1, "Char")
	}
	LOC_TrayIconHandle := DllCall("user32.dll\CreateIconFromResourceEx", "UInt", &ZZZ_InactiveTrayIcon + 22, "UInt", NumGet(ZZZ_InactiveTrayIcon, 14), "Int", 1, "UInt", 0x30000, "Int", 16, "Int", 16, "UInt", 0)
	NumPut(LOC_CurrentWindowID, ZZZ_InactiveTrayIcon, 4)
	, NumPut(1028, ZZZ_InactiveTrayIcon, 8), NumPut(2, ZZZ_InactiveTrayIcon, 12), NumPut(LOC_TrayIconHandle, ZZZ_InactiveTrayIcon, 20)
	, OnMessage(0x404, "TRY_TrayIconShellHook")

	AHK_Log("< TRY_InitTrayIcon()")
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TRY_TrayIconShellHook(wParam, lParam) {
	If (lParam == 514) {
		AHK_ToggleSuspend()
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Tray balloon tip :
;;;;;;;;;;;;;;;;;;;;

TRY_ShowTrayTip(PRM_TrayTipText = "", PRM_TrayTipLevel = 1) {

; PRM_TrayTipLevel == 1 : Info icon
; PRM_TrayTipLevel == 2 : Warning icon
; PRM_TrayTipLevel == 3 : Error icon 
; PRM_TrayTipLevel  < 0 : Warning icon with a timer of -PRM_TrayTipLevel seconds

	TrayTip
	Global TRY_TrayTipEnabled, ZZZ_TrayIconHidden, AHK_ScriptInfo, AHK_ToolTipsEnabled

	TRY_GetTrayTipState()
	If (TRY_TrayTipEnabled) {
		If (!ZZZ_TrayIconHidden) {
			If (PRM_TrayTipText) {
				LOC_TrayTipLevel := (PRM_TrayTipLevel > 0 ? min(max(1, PRM_TrayTipLevel), 3) : 2)
				TrayTip, %AHK_ScriptInfo%, %PRM_TrayTipText%, , % 16 + LOC_TrayTipLevel
				If (LOC_TrayTipLevel == 1) {
					SetTimer, TRY_HideTrayTipTimer, -1000
				} Else If (LOC_TrayTipLevel == 2) {
					SetTimer, TRY_HideTrayTipTimer, % (PRM_TrayTipLevel > 0 ? -3000 : PRM_TrayTipLevel * 1000)
				} Else {
					SetTimer, TRY_HideTrayTipTimer, -5000
				}
			} Else {
				GoSub, TRY_HideTrayTipTimer
			}
		} Else {
			SysGet, LOC_TrayTipDisplay, MonitorWorkArea
			LOC_ToolTipEnabled := AHK_ToolTipsEnabled, AHK_ToolTipsEnabled := 1
			, AHK_ShowToolTip(AHK_ScriptInfo . "`nTray icon hidden`nCtrl + Win + Shift + Q to recover it` " . (PRM_TrayTipText != "" ? "`n`n" : "") . PRM_TrayTipText, PRM_ToolTipSeconds := 2, PRM_Transparency := 255, PRM_ToolTipX := LOC_TrayTipDisplayRight, PRM_ToolTipY := LOC_TrayTipDisplayBottom)
			, AHK_ToolTipsEnabled := LOC_ToolTipEnabled
		}
	}
	Return
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TRY_HideTrayTipTimer:
TrayTip
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TRY_GetTrayTipState() {
	Global TRY_TrayTipEnabled
	Try {
		RegRead, TRY_TrayTipEnabled, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, EnableBalloonTips
	} Catch LOC_Exception {
		AHK_Catch(LOC_Exception, "TRY_GetTrayTipState")
		, TRY_TrayTipEnabled := true
	}
	TRY_TrayTipEnabled := (ErrorLevel || TRY_TrayTipEnabled)
	If (!TRY_TrayTipEnabled) {
		Try {
			RegRead, TRY_TrayTipEnabled, HKEY_LOCAL_MACHINE, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, EnableBalloonTips
		} Catch LOC_Exception {
			AHK_Catch(LOC_Exception, "TRY_GetTrayTipState")
			, TRY_TrayTipEnabled := true
		}
		TRY_TrayTipEnabled := (ErrorLevel || TRY_TrayTipEnabled)
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TRY_InitTrayTip() {
	Global
	TRY_GetTrayTipState()
	If (!TRY_TrayTipEnabled) {
		Suspend, On
		MsgBox, 4148, Balloon Handler - %AHK_ScriptInfo%, The balloon messages are disabled on your system.`nDo you want to enable balloon messages now (highly recommended) ? ; Exclamation, Yes/No buttons & modal
		AHK_ApplySuspendedState()
		IfMsgBox, Yes
		{
			AHK_ToggleTrayTip()
		}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
