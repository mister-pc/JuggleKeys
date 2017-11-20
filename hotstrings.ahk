;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Hotstrings :
;;;;;;;;;;;;;;

#Hotstring EndChars π≤≥ºΩæ~#´ì"îª<ãë'íõ>_-ñó¨+±˜◊Ø∞¶|()[]{}':;"/\,∏.∑ïÖ:?ø!°ßÜá$£Ä•¢©Æô¯ÿ§%â*`n `t

#IfWinActive, ahk_group HOT_HotstringsWindowsGroup
#Hotstring B0

; Action on the same line of the shortcut resets hotstring detection,
; which is not the case when action is described on many lines ended with 'Return'.
; This allows to chain multiple hostrings together, whose one is the same as the beginning of the other


; Locutions :
;;;;;;;;;;;;;

:*:ms:: ; mais
SendInput, {Left}ai{Right}
Return
:*:msa::{Left 2}{BackSpace 2}{Right 2} ; msa (‡ partir de maisa)
:*:cpd::
SendInput, {Left 2}{BackSpace 2}e{Right}en{Right}ant ; cependant (‡ partir de coupd)
Return
:*:cpdt::{BackSpace} ; cependant (‡ partir de cependantt)
:*:cepdt::{Left 2}en{Right}an{Right} ; cependant
:*:dail::{Left 3}'{Right 3}leurs ; d'ailleurs
:*:parail::{Left 3} {Right 3}leurs ; par ailleurs
:C*:ps:: ; puis
SendInput, {Left}ui{Right}
Return
:C*:Ps:: ; Puis
SendInput, {Left}ui{Right}
Return
:C*:psy::{Left 2}{BackSpace 2}{Right 2} ; psy (‡ partir de puisy)
:C*:Psy::{Left 2}{BackSpace 2}{Right 2} ; psy (‡ partir de Puisy)
:C*:pse::{Left 2}{BackSpace 2}{Right 2} ; pse (‡ partir de puise)
:C*:Pse::{Left 2}{BackSpace 2}{Right 2} ; pse (‡ partir de Puise)
:C*:psa::{Left 2}{BackSpace 2}{Right 2} ; psa (‡ partir de puisa)
:C*:Psa::{Left 2}{BackSpace 2}{Right 2} ; psa (‡ partir de Puisa)
:C*:pso::{Left 2}{BackSpace 2}{Right 2} ; pso (‡ partir de puiso)
:C*:Pso::{Left 2}{BackSpace 2}{Right 2} ; pso (‡ partir de Puiso)
:C:ya::{BackSpace}{Left 2}il {Right} {Right} ; il y a
:C:Ya::{BackSpace}{Left}{BackSpace}Il y {Right} ; Il y a
:*:qya:: ; qu'il y a
SendInput, {Left 2}u'il {Right} {Right}
Return
:*:sya:: ; s'il y a
SendInput, {Left 2}'il {Right} {Right}
Return
:C:yap::{BackSpace}{Left 3}il n'{Right} {Right} {Right}as ; il n'y a pas
:C:Yap::{BackSpace}{Left 2}{BackSpace}Il n'y {Right} {Right}as ; Il n'y a pas
:*:qyap::{Left 4}n'{Right 3} {Right}as ; qu'il n'y a pas (‡ partir de qu'il y ap)
:*:syap::{Left 4}n'{Right 3} {Right}as ; s'il n'y a pas (‡ partir de s'il y ap)
:C:nya::{BackSpace}{Left 3}il {Right}'{Right} {Right} ; il n'y a
:C:Nya::{BackSpace}{Left 2}{BackSpace}Il n'{Right} {Right} ; Il n'y a
:C:nyap::{BackSpace}{Left 4}il {Right}'{Right} {Right} {Right}as ; il n'y a pas
:C:Nyap::{BackSpace}{Left 2}{BackSpace}Il n'{Right} {Right} {Right}as ; Il n'y a pas
:*:qny:: ; qu'il n'y (‡ partir de quelqu'uny)
SendInput, {Left 2}{BackSpace}{Left 3}{BackSpace 4}{Right 3}il {Right}'{Right}
Return
:*:qnya:: ; qu'il n'y a (‡ partir de qu'il n'ya)
SendInput, {Left} {Right}
Return
:*:qnyap:: ; qu'il n'y a pas (‡ partir de qu'il n'y ap)
SendInput, {Left} {Right}as
Return
:*:qnyapt::{Left}{BackSpace 2}oin{Right} ; qu'il n'y a point (‡ partir de qu'il n'y a past)
:*:snya:: ; s'il n'y a
SendInput, {Left 3}'il {Right}'{Right} {Right}
Return
:*:snyap::{Left} {Right}as ; s'il n'y a pas (‡ partir de s'il n'y ap)
:C:yena::{BackSpace}{Left 4}il {Right} {Right 2} {Right} ; il y en a
:C:Yena::{BackSpace}{Left 3}{BackSpace}Il y {Right 2} {Right} ; Il y en a
:*:qyena:: ; qu'il y en a
SendInput, {Left 4}u'il {Right} {Right 2} {Right}
Return
:*:syena:: ; s'il y en a
SendInput, {Left 4}'il {Right} {Right 2} {Right}
Return
:C:nyena::{BackSpace}{Left 5}il {Right}'{Right} {Right 2} {Right} ; il n'y en a
:C:Nyena::{BackSpace}{Left 4}{BackSpace}Il n'{Right} {Right 2} {Right} ; Il n'y en a
::qnyena::{BackSpace}{Left 5}u'il {Right}'{Right} {Right 2} {Right} ; qu'il n'y en a
:*:snyena:: ; s'il n'y en a
SendInput, {Left 5}'il {Right}'{Right} {Right 2} {Right}
Return
:C:yenap::{BackSpace}{Left 5}il n'{Right} {Right 2} {Right} {Right}as ; il n'y en a pas
:C:Yenap::{BackSpace}{Left 4}{BackSpace}Il n'y {Right 2} {Right} {Right}as ; Il n'y en a pas
:*:syenap::{Left 7}n'{Right 6} {Right}as ; s'il n'y en a pas (‡ partir de s'il y en ap)
:*:qyenap::{Left 7}n'{Right 6} {Right}as ; qu'il n'y en a pas (‡ partir de qu'il y en ap)
:C:yav::{BackSpace}{Left 3}il {Right} {Right 2}ait ; il y avait
:C:Yav::{BackSpace}{Left 2}{BackSpace}Il y {Right 2}ait ; Il y avait
:*:qyav:: ; qu'il y avait (‡ partir de qu'il y av)
SendInput, ait
Return
:*:syav:: ; s'il y avait (‡ partir de s'il y av)
SendInput, ait
Return
:C:yavp::{BackSpace}{Left 4}il n'{Right} {Right 2}ait {Right}as ; il n'y avait pas
:C:Yavp::{BackSpace}{Left 3}{BackSpace}Il n'y {Right 2}ait {Right}as ; Il n'y avait pas
:*:qyavp::{Left 8}n'{Right 7} {Right}as ; qu'il n'y avait pas (‡ partir de qu'il y avaitp)
:*:syavp::{Left 8}n'{Right 7} {Right}as ; s'il n'y avait pas (‡ partir de s'il y avaitp)
:C:nyav::{BackSpace}{Left 4}il {Right}'{Right} {Right 2}ait ; il n'y avait
:C:Nyav::{BackSpace}{Left 3}{BackSpace}Il n'{Right} {Right 2}ait ; Il n'y avait
::qnyav::{BackSpace}{Left 4}u'il {Right}'{Right} {Right 2}ait ; qu'il n'y avait
:C:yenav::{BackSpace}{Left 5}il {Right} {Right 2} {Right 2}ait ; il y en avait
:C:Yenav::{BackSpace}{Left 4}{BackSpace}Il y {Right 2} {Right 2}ait ; il y en avait
:*:qyenav:: ; qu'il y en avait (‡ partir de qu'il y en av)
SendInput, ait
Return
:*:syenav::  ; s'il y en avait (‡ partir de s'il y en av)
SendInput, ait
Return
:C:nyenav::{BackSpace}{Left 6}il {Right}'{Right} {Right 2} {Right 2}ait ; il n'y en avait
:C:Nyenav::{BackSpace}{Left 5}{BackSpace}Il n'{Right} {Right 2} {Right 2}ait ; Il n'y en avait
::qnyenav::{BackSpace}{Left 6}u'il {Right}'{Right} {Right 2} {Right 2}ait ; qu'il n'y en avait
:*:snyenav:: ; s'il n'y en avait (‡ partir de s'il n'y en av)
SendInput, ait
Return
:*:snyenavp::{Left} {Right}as ; s'il n'y en avait pas (‡ partir de s'il n'y en avaitp)
:C:yenavp::{BackSpace}{Left 6}il n'{Right} {Right 2} {Right 2}ait {Right}as ; il n'y en avait pas
:C:Yenavp::{BackSpace}{Left 5}{BackSpace}Il n'y {Right 2} {Right 2}ait {Right}as ; Il n'y en avait pas
:*:qyenavp::{Left 11}n'{Right 10} {Right}as ; qu'il n'y en avait pas (‡ partir de qu'il y en avaitp)
:*:syenavp::{Left 11}n'{Right 10} {Right}as ; s'il n'y en avait pas (‡ partir de s'il y en avaitp)

:*:dlm:: ; dlm (‡ partir de dËs lorsm)
SendInput, {Left}{BackSpace 3}{Left}{BackSpace 3}{Right 2}
Return
:*:dlmo::{Left 3}ans {Right}a {Right}esure {Right}˘ ; dans la mesure o˘
:*:dc::{Left}on{Right} ; donc
::cad::{BackSpace}{Left}{BackSpace}'est-‡-{Right}ire ; c'est-‡-dire
:*:c‡d::{Left 2}'est-{Right}-{Right}ire ; c'est-‡-dire

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Subordonates :
;;;;;;;;;;;;;;;;

::sil::{BackSpace}{Left 2}'{Right 2} ; s'il
:*:tq:: ; tant que
SendInput, {Left}ant {Right}ue
Return
:*:tq'::{Left}{BackSpace}{Right} ; tant qu' (‡ partir de tant que')
:*:bq:: ; bien que
SendInput, {Left}ien {Right}ue
Return
:*:bq'::{Left}{BackSpace}{Right} ; bien qu' (‡ partir de tant que')
:*:q ::{Left}ue{Right} ; que
:*:q':: ; qu'
SendInput, {Left}u{Right}
Return
:*:q'l::{Left}el{Right}e ; qu'elle (‡ partir de qu'l)
:*:tdq:: ; tandis que
SendInput, {Left 2}an{Right}is {Right}ue
Return
:*:tdq'::{Left}{BackSpace}{Right} ; tandis qu' (‡ partir de tandis que')
:C*:dpq:: ; depuis que (‡ partir de depuisq)
SendInput, {Left} {Right}ue
Return
:C*:Dpq:: ; Depuis que (‡ partir de Depuisq)
SendInput, {Left} {Right}ue
Return
:*:dpq'::{Left}{BackSpace}{Right} ; depuis qu' (‡ partir de depuis que')
:*:dq:: ; dËs que
SendInput, {Left}Ës {Right}ue
Return
:*:dq'::{Left}{BackSpace}{Right} ; dËs qu' (‡ partir de dËs que')
:*:asq:: ; ainsi que
SendInput, {Left 2}in{Right}i {Right}ue
Return
:*:asq'::{Left}{BackSpace}{Right} ; ainsi qu' (‡ partir de ainsi que')
:*:alq:: ; alors que
SendInput, {Left}ors {Right}ue
Return
:*:alq'::{Left}{BackSpace}{Right} ; alors qu' (‡ partir de alors que')
:*:dlq:: ; dËs lors que (‡ partir de dËs lorsq)
SendInput, {Left} {Right}ue
Return
:*:dlq'::{Left}{BackSpace}{Right} ; dËs lors qu' (‡ partir de dËs lors que')
:*:pdq:: ; pendant que
SendInput, {Left 2}en{Right}ant {Right}ue
Return
:*:pdq'::{Left}{BackSpace}{Right} ; pendant qu' (‡ partir de pendant que')
:*:lq:: ; lorsque
SendInput, {Left}ors{Right}ue
Return
:*:lq'::{Left}{BackSpace}{Right} ; lorsqu' (‡ partir de lorsque')
:*:lrsq:: ; lorsque
SendInput, {Left 3}o{Right 3}ue
Return
:*:lrsq'::{Left}{BackSpace}{Right} ; lorsqu' (‡ partir de lorsque')
:*:qd::{Left}uan{Right} ; quand
:*:jqcq:: ; jusqu'‡ ce que (‡ partir de jusquecq)
SendInput, {Left 2}{BackSpace}u'‡ {Right}e {Right}ue
Return
:*:jqcq'::{Left}{BackSpace}{Right} ; jusqu'‡ ce qu' (‡ partir de jusqu'‡ ce que')
:*:jsqc:: ; jusqu'‡ ce (‡ partir de jusquec)
SendInput, {Left}{BackSpace}'‡ {Right}e
Return
:*:jsqcq:: ; jusqu'‡ ce que (‡ partir de jusqu'‡ ceq)
SendInput, {Left} {Right}ue
Return
:*:jsqcq'::{Left}{BackSpace}{Right} ; jusqu'‡ ce qu' (‡ partir de jusqu'‡ ce que')
:*:apq:: ; aprËs que
SendInput, {Left}rËs {Right}ue
Return
:*:apq'::{Left}{BackSpace}{Right} ; aprËs qu' (‡ partir de aprËs que')
:*:avq:: ; avant que
SendInput, {Left}ant {Right}ue
Return
:*:avq'::{Left}{BackSpace}{Right} ; avant que' (‡ partir de avant que')
:*:avtq:: ; avant que (‡ partir de avantq)
SendInput, {Left} {Right}ue
Return
:*:avtq'::{Left}{BackSpace}{Right} ; avant qu' (‡ partir de avant que')
:*:prq:: ; pour que
SendInput, {Left 2}ou{Right} {Right}ue
Return
:*:prq'::{Left}{BackSpace}{Right} ; pour qu' (‡ partir de pour que')
:*:afq:: ; afin que
SendInput, {Left}in {Right}ue
Return
:*:afq'::{Left}{BackSpace}{Right} ; afin qu' (‡ partir de afin que')
:*:slq:: ; selon que
SendInput, {Left 2}e{Right}on {Right}ue
Return
:*:slq'::{Left}{BackSpace}{Right} ; selon qu' (‡ partir de selon que')
:*:mgq:: ; malgrÈ que (‡ partir de malgrÈq)
SendInput, {Left} {Right}ue
Return
:*:mgq'::{Left}{BackSpace}{Right} ; malgrÈ qu' (‡ partir de malgrÈ que')
:*:sfq:: ; sauf que
SendInput, {Left 2}au{Right} {Right}ue
Return
:*:sfq'::{Left}{BackSpace}{Right} ; sauf qu' (‡ partir de sauf que')
:*:cmt::{Left}n{Right} ; comment (‡ partir de commet)
:C:o::{BackSpace 2}Ù ; Ù
:*:cb::{Left}om{Right}ien ; combien
:C*:pq::{Left}our{Right}uoi ; pourquoi
:C*:Pq::{Left}our{Right}uoi ; Pourquoi
:*:parq:: ; parce que
SendInput, {Left}ce {Right}ue
Return
:*:parq'::{Left}{BackSpace}{Right} ; parce qu' (‡ partir de parce que')
:*:psq:: ; puisque (‡ partir de puisq)
SendInput, ue
Return
:*:psq'::{Left}{BackSpace}{Right} ; puisqu' (‡ partir de puisque')
:*:pcq:: ; parce que
SendInput, {Left 2}ar{Right}e {Right}ue
Return
:*:pcq'::{Left}{BackSpace}{Right} ; parce qu' (‡ partir de parce que')
:*:ssq:: ; sans que (‡ partir de sansq)
SendInput, {Left} {Right}ue
Return
:*:ssq'::{Left}{BackSpace}{Right} ; sans qu' (‡ partir de sans que')

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Verbs :
;;;;;;;;;

::cÈ::{BackSpace 2}'est ; c'est
:*:ct:: ; c'Ètait
SendInput, {Left}'È{Right}ait
Return
:*:ctent::{Left 3}{BackSpace}{Right 3} ; c'Ètaient (‡ partir de c'Ètaitent)
::mÈ::{BackSpace 2}'est ; m'est
::nÈ::{BackSpace 2}'est ; n'est
::sÈ::{BackSpace 2}'est ; s'est
::tÈ::{BackSpace 2}'es ; t'ai
:*:jtÈ::{BackSpace}{Left}e {Right}'ai ; je t'ai
:*:jnÈ::{BackSpace}{Left}e {Right}'ai ; je n'ai
:*:jntÈ::{BackSpace}{Left 2}e {Right}e {Right}'ai ; je ne t'ai
:C*:nt::{Left}'È{Right}ai ; n'Ètai
:C*:Nt::{Left}'È{Right}ai ; N'Ètai
:C*:mt:: ; m'Ètai
SendInput, {Left}'È{Right}ai
Return
:C*:Mt:: ; M'Ètai
SendInput, {Left}'È{Right}ai
Return
:*:jnÈ::{BackSpace}{Left}e {Right}'ai ; je n'ai
:C:sc::{BackSpace}{Left 2}e{Right}t-{Right}e ; est-ce
:C:Sc::{BackSpace}{Left}{BackSpace}Est-{Right}e ; Est-ce
:*:ncp::{Left 2}'est-{Right}e {Right}as ; n'est-ce pas
:C*:sq:: ; est-ce que
SendInput, {Left 2}e{Right}t-ce {Right}ue
Return
:C*:sq'::{Left}{BackSpace}{Right} ; est-ce qu' (‡ partir de est-ce que')
:C*:Sq:: ; Est-ce que
SendInput, {Left}{BackSpace}Est-ce {Right}ue
Return
:C*:Sq'::{Left}{BackSpace}{Right} ; Est-ce qu' (‡ partir de Est-ce que')
:C*:sql::{Left}{BackSpace 2}{Left}{BackSpace 5}{Left}{BackSpace}{Right 3} ; sql (‡ partir de est-ce quel)
:C*:squ::{Left}{BackSpace 2}{Left}{BackSpace 5}{Left}{BackSpace}{Right 3} ; squ (‡ partir de est-ce queu)
:C*:Sql::{Left}{BackSpace 2}{Left}{BackSpace 7}S{Right 2} ; Sql (‡ partir de Est-ce queu)
:C*:Squ::{Left}{BackSpace 2}{Left}{BackSpace 7}S{Right 2} ; Squ (‡ partir de Est-ce queu)
:C*:scq:: ; est-ce que
SendInput, {Left 3}e{Right}t-{Right}e {Right}ue
Return
:C*:scq'::{Left}{BackSpace}{Right} ; est-ce qu' (‡ partir de est-ce que')
:C*:Scq:: ; Est-ce que
SendInput, {Left 2}{BackSpace}Est-{Right}e {Right}ue
Return
:C*:Scq'::{Left}{BackSpace}{Right} ; Est-ce qu' (‡ partir de Est-ce que')
:*:ecq:: ; est-ce que
SendInput, {Left 2}st-{Right}e {Right}ue
Return
:*:ecq'::{Left}{BackSpace}{Right} ; est-ce qu' (‡ partir de est-ce que')
:C*:qsq:: ; qu'est-ce que
SendInput, {Left 2}u'e{Right}t-ce {Right}ue{Right}
Return
:C*:qsq'::{Left}{BackSpace}{Right} ; qu'est-ce qu' (‡ partir de qu'est-ce que')
:C*:Qsq:: ; Qu'est-ce que
SendInput, {Left 2}u'e{Right}t-ce {Right}ue{Right}
Return
:C*:Qsq'::{Left}{BackSpace}{Right} ; Qu'est-ce qu' (‡ partir de Qu'est-ce que')
:C*:qcq:: ; qu'est-ce que (‡ partir de quelque choseq)
SendInput, {Left 2}{BackSpace 3}{Left}{BackSpace 5}{Left}'{right}st-{Right 2} {Right}ue
Return
:C*:qcq'::{Left}{BackSpace}{Right} ; qu'est-ce que (‡ partir de qu'est-ce que')
:C*:Qcq:: ; qu'est-ce que (‡ partir de Quelque choseq)
SendInput, {Left 2}{BackSpace 3}{Left}{BackSpace 5}{Left}'{right}st-{Right 2} {Right}ue
Return
:C*:Qcq'::{Left}{BackSpace}{Right} ; qu'est-ce que (‡ partir de qu'est-ce que')
:C:ayÈ::{BackSpace 2}{Left 2}Á{Right} {Right} est ; Áa y est
:C:AyÈ::{BackSpace 2}{Left}{BackSpace}«a {Right} est ; «a y est
:?*:qr:: ; quer
SendInput, {Left}ue{Right}
Return
:*:Í:: ; Ítre
SendInput, tre
Return
:*:Ít::{BackSpace 3} ; Ít (‡ partir de Ítret)
:C:gÈ::{BackSpace 3}j'ai ; j'ai
:C:GÈ::{BackSpace 3}J'ai ; J'ai
::jÈ::{BackSpace 2}'ai ; j'ai
:C:gÈm::{BackSpace}{Left}{BackSpace 2}j'ai{Right]e ; j'aime
:C:GÈm::{BackSpace}{Left}{BackSpace 2}J'ai{Right]e ; J'aime
::jÈm::{BackSpace}{Left}{BackSpace}'ai{Right}e ; j'aime
:C*:gt::{Left}{BackSpace}j'È{Right}ais ; j'Ètais
:C*:Gt::{Left}{BackSpace}J'È{Right}ais ; J'Ètais
:C*:gv::{Left}{BackSpace}j'a{Right}ais ; j'avais
:C*:Gv::{Left}{BackSpace}J'a{Right}ais ; J'avais
:*:jv::{Left}'a{Right}ais ; j'avais
:*:nv:: ; n'avai
SendInput, {Left}'a{Right}ai
Return
:C:v::{BackSpace}ais ; vais

::fre::{BackSpace}{Left 2}ai{Right 2} ; faire
::fÈ::{BackSpace 2}ait ; fait
::fo::{BackSpace 2}aut ; faut
:C*:ft:: ; font
SendInput, {Left}on{Right}
Return
:C*:Ft:: ; Font
SendInput, {Left}on{Right}
Return
:C*:ftp::{Left 2}{BackSpace 2}{Right 2} ; ftp (‡ partir de fontp)
:C*:Ftp::{Left 2}{BackSpace 2}{Right 2} ; Ftp (‡ partir de Fontp)
::st::{BackSpace}{Left}on{Right} ; sont
:*:vx::{Left}eu{Right} ; veux
::ve::{BackSpace}ut ; veut
::vo::{BackSpace 2}aut ; vaut
:*:vd::{Left}en{Right} ; vend
:*:vt::{Left}on{Right} ; vont
:*:cmc:: ; commence (‡ partir de commec)
SendInput, {Left}n{Right}e
Return
:*:cmÁ::{Left}n{Right}a ; commenÁa (‡ partir de commeÁ)
:*:dvl:: ; dvl (‡ partir de diversl)
SendInput, {Left}{BackSpace 3}{Left}{BackSpace}{Right 2}
Return
:*:dvlp:: ; dÈvelopp
SendInput, {Left 3}È{Right}e{Right}o{Right}p
Return
:*:dvlpt::{Left}emen{Right} ; dÈveloppement (‡ partir de dÈveloppt)
:*:cprd::{Left 3}{BackSpace}m{Right 2}en{Right} ; comprend (‡ partir de couprd)
:?*:prd:: ; prend
SendInput, {Left}en{Right}
Return
:?*:dpd:: ; dÈpend (‡ partir de depuisd)
SendInput, {Left}{BackSpace 3}{Left}{BackSpace}È{Right}en{Right}
Return
:*:px::{Left}eu{Right} ; peux
:*:pt::
SendInput, {Left}eu{Right} ; peut
Return
:*:mq::{Left}an{Right}u ; manqu
:C*:djn::{Left}{BackSpace}eu{Right} ; dÈjeun (‡ partir de dÈj‡n)
:C*:Djn::{Left}{BackSpace}eu{Right} ; DÈjeun (‡ partir de DÈj‡n)
:*:jspr::{Left 3}'e{Right 2}Ë{Right}e ; j'espËre
:*:spr::{Left 3}e{Right 2}Ë{Right}e ; espËre
:?*:parapl:: ; parapluie
Return
:?*:apl::{Left}pe{Right} ; appel
:*:pvr::{Left 2}ou{Right}oi{Right} ; pouvoir
:*:pvoir::{Left 4}ou{Right 4} ; pouvoir
:*:pvai::{Left 3}ou{Right 3} ; pouvai
:*:pvons::{Left 4}ou{Right 4} ; pouvons
:*:pvez::{Left 3}ou{Right 3} ; pouvez
:*:pvions::{Left 5}ou{Right 5} ; pouvions
:*:pviez::{Left 4}ou{Right 4} ; pouviez
:*:pvt::{Left 2}eu{Right}en{Right} ; peuvent
:*:pvent::{Left 4}eu{Right 4} ; peuvent
:*:pvant::{Left 4}ou{Right 4} ; pouvant
:*:vlt::{Left 2}eu{Right}en{Right} ; veulent
:*:vlent::{Left 4}eu{Right 4} ; veulent

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Adverbs :
;;;;;;;;;;;

::dab::{BackSpace}{Left 2}'{Right 2}ord ; d'abord
:*:mm:: ; mÍme
SendInput, {Left}Í{Right}e
Return
:C*:+to::
SendInput, {BackSpace}{Left}{BackSpace}plu{Right}Ùt ; plutÙt
Return
:C*:+To::
SendInput, {BackSpace 3}PlutÙt ; PlutÙt
Return
:*:+tot::{BackSpace} ; plutÙt (‡ partir de plutÙtt)
:*:pto:: ; plutÙt (‡ partir de peuto)
SendInput, {BackSpace}{Left}{BackSpace 2}lu{Right}Ùt
Return
:*:ptot::{BackSpace} ; plutÙt (‡ partir de plutÙtt)
::+-::{BackSpace 3}± ; ±
:*:++ ::{Left}{BackSpace 2}plus{Right} ; plus 
:*:++.::{Left}{BackSpace 2}plus{Right} ; plus.
:*:++,::{Left}{BackSpace 2}plus{Right} ; plus,
:*:++)::{Left}{BackSpace 2}plus{Right} ; plus)
:*:+ou-::{BackSpace}{Left 2}{BackSpace}plus {Right 2} moins ; plus ou moins
:*:-- ::{Left}{BackSpace 2}moins{Right} ; moins 
:*:--.::{Left}{BackSpace 2}moins{Right} ; moins.
:*:--,::{Left}{BackSpace 2}moins{Right} ; moins,
:*:--)::{Left}{BackSpace 2}moins{Right} ; moins)
:*:‡pp::{Left 2} {Right}eu {Right}rËs ; ‡ peu prËs
:*:q‡pp::{Left 3}u'{Right} {Right}eu {Right}rËs ; qu'‡ peu prËs
:C*:vm::{Left]rai{Right}ent ; vraiment
:C*:Vm::{Left]rai{Right}ent ; vraiment
:*:vraimt::{Left}en{Right} ; vraiment
:*:mx::{Left}ieu{Right} ; mieux
:*:prsq::{Left 2}e{Right 2}ue ; presque
:*:tlm::{Left 2}el{Right}e{Right}ent ; tellement
::ac::{BackSpace 2}ssez ; assez
::b::{BackSpace}ien ; bien
:*:bcp::{Left 2}eau{Right}ou{Right} ; beaucoup
:*:t‡f::{Left 2}out {Right} {Right}ait ; tout ‡ fait
:*:surtt::{Left}ou{Right} ; surtout
:*:deds::{Left}an{Right} ; dedans
:*:deh:: ; dehors
SendInput, ors
Return
:*:deho::{BackSpace 3} ; deho (‡ partir de dehorso)
:*:partt::{Left}ou{Right} ; partout
::ens::{BackSpace}emble ; ensemble
:*:qens::{Left 3}u'{Right 3}emble ; qu'ensemble
:*:pourtt::{Left}an{Right} ; pourtant
:*:prtant::{Left 5}ou{Right 5} ; pourtant
:*:prtt::{Left 3}ou{Right 2}an{Right} ; pourtant
:*:partt::{Left}ou{Right} ; partout
:*:seult::{Left}emen{Right} ; seulement
:*:vc::{Left}oi{Right}i ; voici
::vl::{BackSpace}{Left}oi{Right}‡ ; voil‡
:C*:dj:: ; dÈj‡
SendInput, {Left}È{Right}‡
Return
:C*:Dj:: ; DÈja
SendInput, {Left}È{Right}‡
Return
:*:svt::{Left 2}ou{Right}en{Right} ; souvent
:*:tdm::{Left 2}out {Right}e {Right}Íme ; tout de mÍme
:*:pe'::{Left}{BackSpace}'t-Ít{Right} ; p't-Ít'
::pe::{BackSpace}ut-Ítre ; peut-Ítre
:*:nimp::{Left 3}'{Right 3}orte ; n'importe
:C*:tjr:: ; toujours
SendInput, {Left 2}ou{Right}ou{Right}s
Return
:C*:tjrs::{BackSpace} ; toujours (‡ partir de toujourss)
:C*:Tjr:: ; Toujours
SendInput, {Left 2}ou{Right}ou{Right}s
Return
:C*:Tjrs::{BackSpace} ; Toujours (‡ partir de Toujourss)
:C*:TJRS::{Left 3}OU{Right}OU{Right 2} ; TOUJOURS
:*:p ::{Left}as{Right} ; pas
:*:p,::{Left}as{Right} ; pas,
:*:p;::{Left}as{Right}{Space} ; pas ;
:C*:p.::{Left}as{Right} ; pas.
:*:jms::{Left 2}a{Right}ai{Right} ; jamais
::h::{BackSpace}ein ; hein
::vi::{BackSpace}{Left}{BackSpace}ou{Right} ; oui
:*:ttf::{Left}e{Right}ois ; toutefois (‡ partir de toutf)
:*:nm::{Left}Èan{Right}oins ; nÈanmoins
:*:parex::{Left 2} {Right 2}emple ; par exemple
:C*:stp::{Left 2}'il {Right}e {Right}laÓt ; s'il te plaÓt
:C*:Stp::{Left 2}'il {Right}e {Right}laÓt ; S'il te plaÓt
:C*:svp::{Left 2}'il {Right}ous {Right}laÓt ; s'il vous plaÓt
:C*:Svp::{Left 2}'il {Right}ous {Right}laÓt ; S'il vous plaÓt
:*:cdt::{Left 2}or{Right}ialemen{Right} ; cordialement
:*:cdlt::{Left 3}or{Right}ia{Right}emen{Right} ; cordialement
:*:simplt::{Left}emen{Right} ; simplement

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Positions :
;;;;;;;;;;;;;

:?*:avt:: ; avant
SendInput, {Left}an{Right}
Return
:*:qavt::{Left 3}u'{Right 2}an{Right} ; qu'avant
:*:dvt::{Left}{BackSpace 3}{Left}{BackSpace}e{Right}an{Right} ; devant (‡ partir de diverst)
::dr::{BackSpace}{Left}e{Right}riËre ; derriËre
:*:dbt::{Left 2}e{Right}ou{Right} ; debout
:*:pdt::{Left 2}en{Right}an{Right} ; pendant
:C*:Dp:: ; Depuis
SendInput, {Left}e{right}uis
Return
:C*:dp:: ; depuis
SendInput, {Left}e{right}uis
Return
:*:ds:: ; dans
SendInput, {Left}an{Right}
Return
:*:dh::{Left}e{Right}ors ; dehors
:*:lb::{Left}‡-{Right}as ; l‡-bas
:*:jq:: ; jusque
SendInput, {Left}us{Right}ue
Return
:*:jq'::{Left 2}us{Right}u{Right} ; jusqu' (‡ partir de jusque')
:*:jsq::
SendInput, {Left 2}u{Right 2}ue ; jusque
Return
:*:jsq'::{Left}{BackSpace}{Right} ; jusqu' (‡ partir de jusque')
::vr::{BackSpace}{Left}e{Right}s ; vers
::tr::{BackSpace}{Left}ou{Right} ; tour
::atr::{BackSpace}{Left 2}u{Right}ou{Right} ; autour
::apr::{BackSpace}Ës ; aprËs
:*:qapr::{Left 3}u'{Right 3}Ës ; qu'aprËs
:C*:apd:: ; ‡ partir de
SendInput, {Left 2}{BackSpace}‡ {Right}artir {Right}e
Return
:C*:‡pd:: ; ‡ partir de
SendInput, {Left 2} {Right}artir {Right}e
Return
:C*:Apd:: ; ¿ partir de
SendInput, {Left 2}{BackSpace}¿ {Right}artir {Right}e
Return
:C*:¿pd:: ; ¿ partir de
SendInput, {Left 2} {Right}artir {Right}e
Return
:C*:apd'::{Left}{BackSpace}{Right} ; ‡ partir d' (‡ partir de ‡ partir de')
:C*:‡pd'::{Left}{BackSpace}{Right} ; ‡ partir d' (‡ partir de ‡ partir de')
:C*:Apd'::{Left}{BackSpace}{Right} ; ¿ partir d' (‡ partir de ¿ partir de')
:C*:¿pd'::{Left}{BackSpace}{Right} ; ¿ partir d' (‡ partir de ¿ partir de')
:*:q‡::{Left}u'{Right} ; qu'‡
:*:pm:: ; parmi
SendInput, {Left}ar{Right}i
Return
:C*:PME::{Left}{BackSpace}{Left}{BackSpace 2}{Right 2} ; PME (‡ partir de PARMIE)
::av::{BackSpace}ec ; avec
:*:qav::{Left 2}u'{Right 2}ec ; qu'avec
:*:v‡v:: ; vis-‡-vis
SendInput, {Left 2}is-{Right}-{Right}is
Return
:*:v‡vd:: ; vis-‡-vis de (‡ partir de vis-‡-visd)
SendInput, {Left} {Right}e
Return
:*:v‡vd'::{Left}{BackSpace}Right} ; vis-‡-vis de (‡ partir de vis-‡-vis de')
:*:sf::{Left}au{Right} ; sauf
:*:ss:: ; sans
SendInput, {Left}an{Right}
Return
:*:ssd::{BackSpace 5}SSD ; SSD (‡ partir de sansd)
:*:ssh::{Left 2}{BackSpace 2}{Right 2} ; ssh (‡ partir de sansh)
:*:sso::{Left 2}{BackSpace 2}{Right 2} ; sso (‡ partir de sanso)
::s_::{BackSpace 2}ur ; sur
::_s::{BackSpace}{Left}{BackSpace}{Right}ous ; sous
:*:dess:: ; dessous
SendInput, ous
Return
:*:desse::{Left}{BackSpace 3}{Right} ; desse (‡ partir de dessouse)
:*:dessi::{Left}{BackSpace 3}{Right} ; dessi (‡ partir de dessousi)
:*:dessu::{Left}{BackSpace 3}{Right} ; dessu (‡ partir de dessousu)
::pr::{BackSpace}{Left}ou{Right} ; pour
:*:ctre::{Left 3}{BackSpace 5}on{Right 3} ; contre (‡ partir de c'Ètaitre)
::af::{BackSpace}in ; afin
:*:qaf::{Left 2}u'{Right 2}in ; qu'afin
:*:afd:: ; afin de
SendInput, {Left}in {Right}e
Return
:*:afd'::{Left}{BackSpace}{Right} ; afin d' (‡ partir de afin de')
::sl::{BackSpace}{Left}e{Right}on ; selon
:*:cm::
SendInput, {Left}om{Right}e ; comme
Return
:*:cmu::{Left}{BackSpace 2}{Left}{BackSpace}{Right 2} ; cmu (‡ partir de commeu)
:*:mg::
SendInput, {Left}al{Right}rÈ ; malgrÈ
Return
:*:qt::{Left}uan{Right} ; quant
:*:lx::{Left}ieu{Right} ; lieux
:*:ald ::{Left 3}u {Right}ieu {Right}e{Right} ; au lieu de
:*:ald'::{Left 3}u {Right}ieu {Right 2} ; au lieu d'

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Pronuns :
;;;;;;;;;;;

:*:chq::{Left}a{Right}ue ; chaque
:*:tt:: ; tout
SendInput, {Left}ou{Right}
Return
:C*:TTC::{Left 2}{BackSpace 2}{Right 2} ; TTC (‡ partir de TOUTC)
:*:ts:: ; tous
SendInput, {Left}ou{Right}
Return
:*:tsa::{Left 2}{BackSpace 2}{Right 2} ; tsa (‡ partir de tousa)
:*:tse::{Left 2}{BackSpace 2}{Right 2} ; tse (‡ partir de touse)
:*:tsÈ::{Left 2}{BackSpace 2}{Right 2} ; tsÈ (‡ partir de tousÈ)
:*:tsi::{Left 2}{BackSpace 2}{Right 2} ; tsi (‡ partir de tousi)
:*:tso::{Left 2}{BackSpace 2}{Right 2} ; tso (‡ partir de touso)
:*:tsu::{Left 2}{BackSpace 2}{Right 2} ; tsu (‡ partir de tousu)
:*:ns::{Left}ou{Right} ; nous
:*:vs::{Left}ou{Right} ; vous
:C*:u2::{BackSpace}{Left}toi a{Right}ssi ; toi aussi
:C*:U2::{BackSpace 2}Toi aussi ; Toi aussi
:*:cx::{Left}eu{Right} ; ceux
:*:cert&::{BackSpace}ain ; certain
:*:d&::{BackSpace}'un ; d'un
:*:l&::{BackSpace}'un ; l'un
:*:dt::{Left}on{Right} ; dont
:?*:qa::{Left}u{Right} ; qua
:?*:qe::{Left}u{Right} ; que
:?*:qÈ::{Left}u{Right} ; quÈ
:?*:qË::{Left}u{Right} ; quË
:?*:qÍ::{Left}u{Right} ; quÍ
:?*:qi:: ; qui
SendInput, {Left}u{Right}
Return
:*:qil::{Left 2}'{Right 2} ; qu'il (‡ partir de quil)
:?*:qo::{Left}u{Right} ; quo

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Some :
;;;;;;;;

::r::{BackSpace}ien ; rien
::ca::{BackSpace}{Left}{BackSpace}Á{Right} ; Áa
::clc::{BackSpace}{Left 2}e{Right}ui-{Right}i ; celui-ci
:*:qq:: ; quelque
SendInput, {Left}uel{Right}ue
Return
:*:q1:: ; quelqu'un
SendInput, {BackSpace}uelqu'un
Return
:*:q&::{BackSpace}u'un ; qu'un
:*:qun:: ; quelqu'un
SendInput, {Left 2}uelqu'{Right 2}
Return
:*:qn:: ; quelqu'un
SendInput, {Left}uelqu'u{Right}
Return
:*:qqn:: ; quelqu'un (‡ partir de quelquen)
SendInput, {Left}{BackSpace}'u{Right}
Return
:*:qq&:: ; quelqu'un (‡ partir de quelque&)
SendInput, {BackSpace 2}'un
Return
:*:qq1:: ; quelqu'un (‡ partir de quelque1)
SendInput, {BackSpace 2}'un
Return
:*:qqns::{Left 3}{BackSpace}es-{Right 3} ; quelques-uns (‡ partir de quelqu'uns)
:*:qq&s::{Left 3}{BackSpace}es-{Right 3} ; quelques-uns (‡ partir de quelqu'uns)
:*:qq1s::{Left 3}{BackSpace}es-{Right 3} ; quelques-uns (‡ partir de quelqu'uns)
:*:qq&es::{Left 4}{BackSpace}es-{Right 4} ; quelques-unes (‡ partir de quelqu'unes)
:*:qq1es::{Left 4}{BackSpace}es-{Right 4} ; quelques-unes (‡ partir de quelqu'unes)
:*:q1s::{Left 3}{BackSpace}es-{Right 3} ; quelques-uns (‡ partir de quelqu'uns)
:*:quns::{Left 3}{BackSpace}es-{Right 3} ; quelques-uns (‡ partir de quelqu'uns)
:*:qns::{Left 3}{BackSpace}es-{Right 3} ; quelques-uns (‡ partir de quelqu'uns)
:*:qunes::{Left 4}{BackSpace}es-{Right 4} ; quelques-unes (‡ partir de quelqu'unes)
:*:qnes::{Left 4}{BackSpace}es-{Right 4} ; quelques-unes (‡ partir de quelqu'unes)
:C*:+r:: ; plusieurs
SendInput, {Left}{BackSpace}plusieu{Right}s
Return
:*:p+::{BackSpace}lusieurs ; plusieurs
:C*:+rs::{BackSpace} ; plusieurs (‡ partir de plusieurss)
:C*:+R:: ; Plusieurs
SendInput, {BackSpace 2}Plusieurs
Return
:C*:+Rs::{BackSpace} ; Plusieurs (‡ partir de Plusieurss)
:C*:+ir:: ; plusieurs
SendInput, {Left 2}{BackSpace}plus{Right}eu{Right}s
Return
:C*:+irs::{BackSpace} ; plusieurs (‡ partir de plusieurss)
:C*:+Ir:: ; Plusieurs
SendInput, {Left}{BackSpace 2}Plusieu{Right}s
Return
:C*:+Irs::{BackSpace} ; Plusieurs (‡ partir de plusieurss)
:C*:+ieur:: ; plusieurs
SendInput, {Left 4}{BackSpace}plus{Right 4}s
Return
:C*:+ieurs::{BackSpace} ; plusieurs (‡ partir de plusieurss)
:C*:+Ieur:: ; Plusieurs
SendInput, {Left 3}{BackSpace 2}Plusi{Right 3}s
Return
:C*:+ieurs::{BackSpace} ; plusieurs (‡ partir de plusieurss)
:C*:+Ieurs::{BackSpace} ; Plusieurs (‡ partir de Plusieurss)

:*:dql:: ; duquel (‡ partir de dËs quel)
SendInput, {Left 4}{BackSpace 3}u{Right 4}
Return
:*:dqls::{Left 5}{BackSpace}es{Right 5} ; desquels (‡ partir de duquels)
:*:dqles::{Left 6}{BackSpace}es{Right 4}l{Right 2} ; desquelles (‡ partir de duqueles)
:*:lql:: ; lequel (‡ partir de lorsquel)
SendInput, {Left 4}{BackSpace 3}e{Right 4}
Return
:*:lqls::{Left 5}s{Right 5} ; lesquels (‡ partir de lequels)
:*:lqle:: ; laquelle (‡ partir de lequele)
SendInput, {Left 5}{BackSpace}a{Right 4}l{Right}
:*:lqles::{Left 7}{BackSpace}es{Right 7} ; lesquelles (‡ partir de laquelles)
:*:aql:: ; auquel
SendInput, {Left 2}u{Right}ue{Right}
Return
:*:aqls::{Left 5}x{Right 5} ; auxquels (‡ partir de auquels)
:*:aqles::{Left 6}x{Right 4}l{Right 2} ; auxquelles (‡ partir de auqueles)
:C*:qc:: ; quelque chose
SendInput, {Left}uelque {Right}hose
Return
:C*:Qc:: ; Quelque chose
SendInput, {Left}uelque {Right}hose
Return
:*:ql:: ; quel
SendInput, {Left}ue{Right}
Return
:*:qle::{Left}l{Right} ; quelle (‡ partir de quele)
:*:qlc::onque ; quelconque (‡ partir de quelc)
:*:qlq::{Left}con{Right}ue ; quelconque (‡ partir de quelq)
:*:qic::onque ; quiconque (‡ partir de quic)
:*:qp::{Left}uelque {Right}art ; quelque part
:*:qf::{Left}uelque {Right}ois ; quelque fois
:*:qj::{Left}uelques {Right}ours ; quelques jours
:*:dv:: ; divers
SendInput, {Left}i{Right}ers
Return
:*:dx::{Left}eu{Right} ; deux
:*:trs::{Left}oi{Right} ; trois
:*:cq::{Left}in{Right} ; cinq
:*:nf::{Left}eu{Right} ; neuf
:*:dze::{Left 2}ou{Right 2} ; douze
:*:trz::{Left}ei{Right}e ; treize
:*:vgt::{Left 2}in{Right 2} ; vingt
:*:4ante::{Left 4}{BackSpace}quar{Right 4} ; quarante
:*:'ante::{Left 4}{BackSpace}quar{Right 4} ; quarante
:*:5ante::{Left 4}{BackSpace}cinqu{Right 4} ; cinquante
:*:(ante::{Left 4}{BackSpace}cinqu{Right 4} ; cinquante
:*:6ante::{Left 4}{BackSpace}soix{Right 4} ; soixante
:*:-ante::{Left 4}{BackSpace}soix{Right 4} ; soixante
:*:7ante::{Left 4}{BackSpace}soix{Right 4}-dix ; soixante-dix
:*:Ëante::{Left 4}{BackSpace}soix{Right 4}-dix ; soixante-dix
:*:7dx::{Left 2}{BackSpace}soixante-{Right}i{Right} ; soixante-dix
:*:7dix::{Left 3}{BackSpace}soixante-{Right 3} ; soixante-dix
:*:Ëdx::{Left 2}{BackSpace}soixante-{Right}i{Right} ; soixante-dix
:*:Ëdix::{Left 3}{BackSpace}soixante-{Right 3} ; soixante-dix
:*:4vgt::{Left 3}{BackSpace}quatre-{Right}in{Right 2} ; quatre-vingt
:*:9dx::{Left 2}{BackSpace}quatre-vingt-{Right}i{Right} ; quatre-vingt-dix
:*:9dix::{Left 3}{BackSpace}quatre-vingt-{Right 3} ; quatre-vingt-dix
:*:Ádx::{Left 2}{BackSpace}quatre-vingt-{Right}i{Right} ; quatre-vingt-dix
:*:Ádix::{Left 3}{BackSpace}quatre-vingt-{Right 3} ; quatre-vingt-dix

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Adjectives :
;;;;;;;;;;;;;;

:*:fx::{Left}au{Right}
:*:std:: ; standard
SendInput, {Left}andar{Right}
Return
:*:bx::{Left}eau{Right} ; beaux
:?*:grd::{Left}an{Right} ; grand
:?*:lrd::{Left 2}ou{Right 2} ; lourd
:*:mv:: ; mauvais
SendInput, {Left}au{Right}ais
Return
:?*:lg:: ; long
SendInput, {Left}on{Right}
Return
:*:lge::{Left}u{Right} ; longue (‡ partir de longe)
:*:lgr:: ; longueur (‡ partir de longr)
SendInput, {Left}ueu{Right}
Return
:?*:lgo::{Left 2}{BackSpace 2}{Right 2} ; lgo (‡ partir de longo)
:?*:lgrÈ::{Left 3}{BackSpace 2}{Right 3} ; lgrÈ (‡ partir de longrÈ)
:*:lgr::{Left}ueu{Right} ; longueur (‡ partir de longr)
:*:bulga::{Left 2}{BackSpace 2}{Right 2} ; bulga (‡ partir de bulonga)
:?*:dbl::{Left 2}ou{Right 2} ; doubl
:?*:crt::{Left 2}ou{Right 2} ; court
:*:rd:: ; rond
SendInput, {Left}on{Right}
Return
:*:gche::{Left 3}au{Right 3} ; gauche
:?*:drt::{Left}oi{Right} ; droit
:*:ht:: ; haut
SendInput, {Left}au{Right}
Return
:*:htr::{Left}eu{Right} ; hauteur
:*:horiz::ontal ; horizontal
:*:cj::{Left}i-{Right}oint ; ci-joint
:?*:nveau::{Left 3}{BackSpace 2}{Left}{BackSpace 2}ou{Right 4} ; nouveau (‡ partir de n'avaieau)
:*:nvo::{BackSpace 2}{Left 2}{BackSpace 2}ou{Right}e{Right}u ; nouveau (‡ partir de n'avaio)
:?*:nvl::{Left}{BackSpace 2}{Left}{BackSpace 2}ou{Right}e{Right} ; nouvel (‡ partir de n'avail)
:*:nvel::{Left 2}{BackSpace 2}{Left}{BackSpace 2}ou{Right 3} ; nouvel (‡ partir de n'avaiel)
::st.::{BackSpace 2}{Left}ain{Right} ; saint
::sts::{BackSpace}{Left 2}ain{Right 2} ; saints
::ste::{BackSpace}{Left 2}ain{Right 2} ; sainte
::stes::{BackSpace}{Left 3}ain{Right 3} ; saintes
:*:mdr::{Left 2}ort {Right}e {Right}ire ; mort de rire
:*:dsl::{Left 2}{BackSpace 2}È{Right}o{Right}È ; dÈsolÈ (‡ partir de dansl)
:*:chd::{Left}au{Right} ; chaud
:*:frd::{Left}oi{Right} ; froid

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Things :
;;;;;;;;;;

:*:msg::{Left 2}{BackSpace 2}es{Right}a{Right}e ; message (‡ partir de maisg)
:*:pj:: ; piËce jointe
SendInput, {Left}iËce {Right}ointe
Return
:*:pjs::{Left 8}s{Right 8} ; piËces jointes (‡ partir de piËce jointes)
:*:txt::{Left 2}{BackSpace 2}e{Right 2}e ; texte (‡ partir de tauxt)
::doc::{BackSpace}ument ; document
::docs::{BackSpace}{Left}ument{Right} ; documents
:*:chp::{Left}am{Right} ; champ
:C*:Df::{Left}È{Right}aut ; DÈfaut
:C*:df::{Left}È{Right}aut ; dÈfaut
:?*:nbr:: ; nombr
SendInput, {Left 2}om{Right 2}
Return
:*:nbrx::{Left}eu{Right} ; nombreux (‡ partir de nombrx)
:*:num:: ; numÈr
SendInput, Èr
Return
:*:numÈr:: ; numÈr (‡ partir de numÈrÈr)
SendInput, {BackSpace 2}
Return
:*:numb::{Left}{BackSpace 2}{Right} ; numb (‡ partir de numÈrb)
:*:travx::{Left}au{Right} ; travaux
:*:trvx::{Left 2}a{Right}au{Right} ; travaux
:?*:trvl::{Left 2}a{Right}ai{Right} ; travail
:?*:travl::{Left}ai{Right} ; travail
:?*:jx::{Left}eu{Right} ; jeux
:*:yx::{Left}eu{Right} ; yeux
:?*:pds::{Left 2}oi{Right 2} ; poids
:?*:src::{Left 2}ou{Right 2}e ; source
:*:bt:: ; bout
SendInput, {Left}ou{Right}
Return
:*:rmq::{Left 2}e{Right}ar{Right}u ; remarqu
:?*:grp:: ; groupe
SendInput, {Left}ou{Right}e
Return
:?*:grpe::{BackSpace} ; groupe (‡ partir de groupee)
:?*:grpÈ::{Left}{BackSpace}{Right} ; groupÈ (‡ partir de groupeÈ)
:*:trp:: ; troupe
SendInput, {Left}ou{Right}e
Return
:*:trpe::{BackSpace} ; troupe (‡ partir de troupee)
:*:trpÈ::{Left}{BackSpace}{Right} ; troupÈ (‡ partir de troupeÈ)
:C*:rf::{Left}È{Right}Èren ; rÈfÈren
:C*:Rf::{Left}È{Right}Èren ; RÈfÈren
:*:rte::{Left 2}ou{Right 2} ; route
:*:chb::{Left}am{Right} ; chamb
::Ètab::{BackSpace}lissement ; Ètablissement
::Ètabs::{BackSpace}{Left}lissement{Right} ; Ètablissements
::philo::{BackSpace}sophie ; philosophie
:?*:oeuf::{Left 2}{BackSpace 2}ú{Right 2} ; úuf
:?*:oeur::{Left 2}{BackSpace 2}ú{Right 2} ; úur
:C?*:oeuvr::{Left 3}{BackSpace 2}ú{Right 3} ; úuvre
:C?*:Oeuvr::{Left 3}{BackSpace 2}å{Right 3} ; åuvre
:*:voeu::{Left 2}{BackSpace 2}ú{Right 2} ; vúu
:C*:oeil::{Left 2}{BackSpace 2}ú{Right 2} ; úil
:C*:Oeil::{Left 2}{BackSpace 2}å{Right 2} ; åil
:*:oeno::{Left 2}{BackSpace 2}ú{Right 2} ; úno
:*:oest::{Left 2}{BackSpace 2}ú{Right 2} ; úst
:*:noeud::{Left 2}{BackSpace 2}ú{Right 2} ; núud
:*:foetus::{Left 3}{BackSpace 2}ú{Right 3} ; fútus
:*:oedipe::{Left 4}{BackSpace 2}{Right 4} ; ådipe
:*:oesophage::{Left 7}{BackSpace 2}ú{Right 7} ; úsophage
:*:aeternam::{Left 6}{BackSpace 2}ú{Right 6} ; Êternam
:*:vitae::{BackSpace 2}Ê ; vitÊ
:*:aequo::{Left 3}{BackSpace 2}{Right 3} ; Êquo

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Actions :
;;;;;;;;;;;

:*:np::{Left}o {Right}roblem ; no problem
:*:pb::{Left}ro{Right}lËme ; problËme
::prob::{BackSpace}lËme ; problËme
::probs::{BackSpace}{Left}lËme{Right} ; problËmes
:*:prb::{Left}o{Right}lËme ; problËme
:*:fd::{Left}on{Right} ; fond
:C*:rv::{Left}endez-{Right}ous ; rendez-vous
:C*:Rv::{Left}endez-{Right}ous ; Rendez-vous
:C*:rdv::{Left 3}{BackSpace}e{Right 2}ez-{Right}ous ; rendez-vous (‡ partir de rondv)
:C*:Rdv::{Left 3}{BackSpace}e{Right 2}ez-{Right}ous ; Rendez-vous (‡ partir de Rondv)
:C*:RDV::{Left 2}{BackSpace 2}{Right 2} ; RDV (‡ partir de RonDV)
::prop::{BackSpace}osition ; proposition
::props::{BackSpace}{Left}osition{Right} ; propositions
::propo::{BackSpace}sition ; proposition
::proba::{BackSpace}bilitÈ ; probabilitÈ
::probas::{BackSpace}{Left}bilitÈ{Right} ; probabilitÈs
:*:tx:: ; taux
SendInput, {Left}au{Right}
Return
:*:cp:: ; coup
SendInput, {Left}ou{Right}
Return
:*:cpam::{BackSpace 6}CPAM ; CPAM (‡ partir de coupam)
:C*:bd::{Left}on{Right} ; bond
:C*:Bd::{Left}on{Right} ; Bond
:C*:xp::{Left 2}e{Right 2}Èri ; expÈri
:C*:Xp::{Left}{BackSpace}Ex{Right}Èri ; ExpÈri
:*:cfg::{Left 2}on{Right}i{Right} ; config
:C?*:fc:: ; fonction
:C?*:Fc:: ; Fonction
SendInput, {Left}on{Right}tion
Return
:*:fct::{Left}nemen{Right} ; fonctionnement
:C*:ctrl::{Left 3}{BackSpace 5}on{Right 2}Ù{Right}e ; contrÙle (‡ partir de c'Ètaitrl)
:C*:Ctrl::{Left 3}{BackSpace 5}{Right 3} ; Ctrl (‡ partir de C'Ètaitrl)
:C:cr::{BackSpace}{Left}ompte-{Right}endu ; compte-rendu
:C:Cr::{BackSpace}{Left}ompte-{Right}endu ; Compte-rendu
:C*:crs::{Left 2}omptes-{Right}endu{Right} ; comptes-rendus
:C*:Crs::{Left 2}omptes-{Right}endu{Right} ; Comptes-rendus
:*:pts::{Left 2}{BackSpace 2}oin{Right 2} ; points (‡ partir de peuts)
:*:m‡d:: ; mise ‡ disposition
SendInput, {BackSpace}{Left 2}ise {Right} {Right}isposition
Return
:*:m‡ds::{BackSpace}{Left 14}s{Right 14} ; mises ‡ disposition (‡ partir de mise ‡ dispositions)
::maj::{BackSpace}{Left}{BackSpace}ise ‡ {Right}our ; mise ‡ jour
:*:majs::{BackSpace}{Left}{BackSpace}ises ‡ {Right}our ; mises ‡ jour
:*:m‡j:: ; mise ‡ jour
SendInput, {Left 2}ise {Right} {Right}our
Return
:*:m‡js::{BackSpace}{Left 7}s{Right 7} ; mises ‡ jour (‡ partir de mise ‡ jours)
::mef::{BackSpace}{Left 2}ise {Right}n {Right}orme ; mise en forme
:*:mefs::{BackSpace}{Left 2}ises {Right}n {Right}orme ; mises en forme
:*:ccl::{Left 2}on{Right 2}usion ; conclusion
::suppr::{BackSpace}ession ; suppression
:*:supprs::{Left}ession{Right} ; suppressions
:*:trt::{Left}ai{Right}ement ; traitement
::event::{BackSpace}{Left 4}{BackSpace}È{Right}Ènem{Right 3} ; ÈvÈnement
:*:events::{Left 5}{BackSpace}È{Right}Ènem{Right 4} ; ÈvÈnements
:*:mvt::{Left}{BackSpace 3}{Left 2}{BackSpace}o{Right 2}emen{Right} ; mouvement (‡ partir de mauvaist)
:?*:chg:: ; chang
SendInput, {Left}an{Right}
Return
:?*:chgt::{Left}emen{Right} ; changement (‡ partir de changt)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Computing :
;;;;;;;;;;;;;

:*:http::{Left 3}{BackSpace 2}{Right 3} ; http (‡ partir de hauttp)
:*:htm::{Left 2}{BackSpace 2}{Right 2} ; htm (‡ partir de hautm)
:*:prog:: ; programm
SendInput, ramm
Return
:*:progr::{BackSpace 4} ; progr (‡ partir de programmr)
:*:progÈn::{Left 2}{BackSpace 4}{Right 2} ; progÈn (‡ partir de programmÈn)
:*:cpu::{Left 2}{BackSpace 2}{Right 2} ; cpu (‡ partir de coupu)
::appli::{BackSpace}cation ; application
:*:applis::{Left}cation{Right} ; applications
:*:cmd::{Left}{BackSpace}an{Right} ; command (‡ partir de commed)
::fic::{BackSpace}hier ; fichier
:*:fics::{Left}hier{Right} ; fichiers
::enreg::{BackSpace}istrement ; enregistrement
:*:enregs::{Left}istrement{Right} ; enregistrements
::dim::{BackSpace}ension ; dimension
:*:dims::{Left}ension{Right} ; dimensions
:*:rg:: ; rang
SendInput, {Left}an{Right}
Return
:*:rgb::{Left 2}{BackSpace 2}{Right 2} ; rgb (‡ partir de rangb)
:C*:agt::{Left}en{Right} ; agent
:C*:Agt::{Left}en{Right} ; Agent
:*:prodr::{Left}ucteu{Right} ; production
::conso::{BackSpace}mmateur ; consommateur
:*:consos::{Left}mmateur{Right} ; consommateurs
:*:dÈcpt::{Left 2}om{Right 2} ; dÈcompt
:*:cpt::{Left 2}{BackSpace}m{Right 2} ; compt (‡ partir de coupt)
:*:mdp:: ; mot de passe
SendInput, {Left 2}ot {Right}e {Right}asse
Return
:*:mdps::{BackSpace}{Left 9}s{Right 9} ; mots de passe (‡ partir de mot de passes)
::env::{BackSpace}iron ; environ
:*:envt::{Left}ironnemen{Right} ; environnement
:*:envs::{Left}ironnement{Right} ; environnements
::dÈv::{BackSpace}eloppement ; dÈveloppement
:*:dÈvs::{Left}eloppement{Right} ; dÈveloppements
:*:b‡s::{Left 2}ac {Right} {Right}able ; bac ‡ sable
::intÈ::{BackSpace}gration ; intÈgration
::rec::{BackSpace}ette ; recette
:*:recs::{Left}ette{Right} ; recettes
:C:mab::{BackSpace}{Left}rche ‡ {Right}lanc ; marche ‡ blanc
:*:pprod::{Left 4}rÈ-{Right 4}uction ; prÈ-production
::prod::{BackSpace}uction ; production
::pf::{BackSpace}{Left}late{Right}orme ; plateforme
:*:pfs::{Left 2}late{Right}orme{Right} ; plateformes
:*:specs::{Left 2}{BackSpace}È{Right}ification{Right} ; spÈcifications
::qualif::{BackSpace}ication ; qualification
:*:qualifs::{Left}ication{Right} ; qualifications
::modif::{BackSpace}ication ; modification
:*:modifs::{Left}ication{Right} ; modifications
::ver::{BackSpace}sion ; version
::liv::{BackSpace}raison ; livraison
:*:livs::{Left}raison{Right} ; livraisons
::conf::{BackSpace}iguration ; configuration
:*:confs::{Left}iguration{Right} ; configurations
::planif::{BackSpace}ication ; planification
:*:planifs::{Left}ication{Right} ; planifications
:C*:mei:: ; mise en intÈgration
SendInput, {Left 2}ise {Right}n {Right}ntÈgration
Return
:C*:meil::{Left}{BackSpace 10}{Left}{BackSpace 2}{Left}{BackSpace 4}{Right 3} ; meil (‡ partir de mise en intÈgrationl)
:C*:meis::{BackSpace}{Left 15}s{Right 15} ; mises en intÈgration (‡ partir de mise en intÈgrations)
:C*:Mei:: ; Mise en intÈgration
SendInput, {Left 2}ise {Right}n {Right}ntÈgration
Return
:C*:Meil::{Left}{BackSpace 10}{Left}{BackSpace 2}{Left}{BackSpace 4}{Right 3} ; Meil (‡ partir de Mise en intÈgrationl)
:C*:Meis::{BackSpace}{Left 15}s{Right 15} ; Mises en intÈgration (‡ partir de Mise en intÈgrations)
:C*:mep:: ; mise en production
SendInput, {Left 2}ise {Right}n {Right}roduction
Return
:C*:meps::{BackSpace}{Left 14}s{Right 14} ; mises en production (‡ partir de mise en productions)
:C*:Mep:: ; Mise en production
SendInput, {Left 2}ise {Right}n {Right}roduction
Return
:C*:Meps::{BackSpace}{Left 14}s{Right 14} ; Mises en production (‡ partir de Mise en productions)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Time :
;;;;;;;;

; :*:lgtps::{Left 2}em{Right 2} ; longtemps (‡ partir de longtps)
:?*:tps::{Left 2}em{Right 2} ; temps
:C?*:bjr:: ; bonjour
:C?*:Bjr:: ; Bonjour
SendInput, {Left 2}on{Right}ou{Right}
Return
:*:smn::{Left 2}e{Right}ai{Right}e ; semaine
:C?*:Jr::{Left}ou{Right} ; Jour
:C?*:jr::{Left}ou{Right} ; jour
:*:hre::{Left 3}{BackSpace}{Right}u{Right 2} ; heure (‡ partir de hiere)
:*:dsm::{Left 2}{BackSpace 2}È{Right}or{Right}ais ; dÈsormais (‡ partir de dansm)
:C*:dl:: ; dËs lors
SendInput, {Left}Ës {right}ors
Return
:C*:Dl:: ; DËs lors
SendInput, {Left}Ës {right}ors
Return
:*:dll::{Left}{BackSpace 3}{Left}{BackSpace 3}{Right 2} ; dll (‡ partir de dËs lorsl)
::ec::{BackSpace}{Left}n{Right}ore ; encore
::ef::{BackSpace}{Left}n{Right}in ; enfin
:*:atf::{Left 2}u{Right}re{Right}ois ; autrefois
:*:avh:: ; avant-hier
SendInput, {Left}ant-{Right}ier
Return
:*:avhr::{BackSpace} ; avant-hier (‡ partir de avant-hierr)
:*:avth:: {Left}-{Right}ier ; avant-hier (‡ partir de avanth)
:*:avth:: {Left}-{Right}ier ; avant-hier (‡ partir de avanth)
:*:avthr::{BackSpace} ; avant-hier (‡ partir de avant-hierr)
:*:hr:: ; hier
SendInput, {Left}ie{Right}
Return
:*:mmt::{Left 3}{BackSpace}o{Right 2}n{Right} ; moment (‡ partir de mÍmet)
:*:maintt::{Left}enan{Right} ; maintenant
:*:mtn::{Left 3}{BackSpace 3}{Right 3}tenant ; maintenant (‡ partir de m'Ètain)
:C*:Sd::
SendInput, {Left}ou{Right}ain ; soudain
Return
:C*:sd::
SendInput, {Left}ou{Right}ain ; soudain
Return
:*:sdc::{Left}{BackSpace 3}{Left}{BackSpace 2}{Right 2} ; sdc (‡ partir de soudainc)
:*:sdf::{Left}{BackSpace 3}{Left}{BackSpace 2}{Right 2} ; sdf (‡ partir de soudainf)
:*:sdk::{Left}{BackSpace 3}{Left}{BackSpace 2}{Right 2} ; sdk (‡ partir de soudaink)
:*:t‡c::{Left 2}out {Right} {Right}oup ; tout ‡ coup
::ast::{BackSpace}{Left 2}us{Right}itÙ{Right} ; aussitÙt
:*:bto::{BackSpace}{Left}{BackSpace 2}ien{Right}Ùt ; bientÙt (‡ partir de bouto)
:C*:auj::ourd'hui ; aujourd'hui
:C*:Auj::ourd'hui ; Aujourd'hui
:*:qauj::{Left 3}u'{Right 3}ourd'hui ; qu'aujourd'hui
:*:d‡p::{Left 2}Ës {Right} {Right}rÈsent ; dËs ‡ prÈsent
:*:aprm::{Left}Ës-{Right}idi ; aprËs-midi
:*:dm:: ; demain
SendInput, {Left}e{Right}ain
Return
:*:dmd::{Left 2}{BackSpace}{Right 2} ; demand (‡ partir demaind)
:C*:Apdm::{Left 3}{BackSpace 4}{Left}{BackSpace}{Left}{BackSpace 2}A{Right 2}Ës-{Right 3}ain ; AprËs-demain (‡ partir de ¿ partir dem)
:*:apdm::{Left 3}{BackSpace 4}{Left}{BackSpace}{Left}{BackSpace 2}a{Right 2}Ës-{Right 3}ain ; aprËs-demain (‡ partir de ‡ partir dem)
:*:aprdm::{Left 2}{BackSpace 2}Ës-{Right}e{Right}ain ; aprËs-demain (‡ partir de aprendm)
::lun::{BackSpace}di ; lundi
::mar::{BackSpace}di ; mardi
:*:mercr:: ; mercredi
SendInput, edi
Return
:*:mercredi::{BackSpace 3} ; mercredi (‡ partir de mercrediedi)
::vendr::{BackSpace}edi ; vendredi
::dim::{BackSpace}anche ; dimanche
:*:w-e::{Left 2}eek{Right 2}nd ; week-end
:*:wes:: ; week-ends
SendInput, {Left}ek-end{Right}
Return
:*:west::{Left 2}{BackSpace 6}{Right 2} ; west (‡ partir de week-endst)
:*:frÈq:: ; frÈquen
SendInput, uen
Return
:*:frÈqu::{BackSpace 3} ; frÈqu (‡ partir de frÈquenu)
:*:frÈqt::{Left 2}mme{Right 2} ; frÈquemment (‡ partir de frÈquent)
:*:hebdo:: ; hebdomadaire
SendInput, madaire
Return
:*:hebdomadaire::{BackSpace 7} ; hebdomadaire (‡ partir de hebdomadairemadaire)
:*:janv:: ; janvier
SendInput, ier
Return
:*:janvi::{BackSpace 3} ; janvi (‡ partir de janvieri)
:*:fÈv:: ; fÈvrier
SendInput, rier
Return
:*:fÈvr::{BackSpace 4} ; fÈvr (‡ partir de fÈvrierr)
:*:aout::{Left}{BackSpace}˚{Right} ; ao˚t
:*:oct:: ; octobre
SendInput, obre
Return
:*:octo::{BackSpace 4} ; octo (‡ partir d'octobreo)
:*:octa::{Left}{BackSpace 4}{Right} ; octa (‡ partir d'octobrea)
:*:octe::{Left}{BackSpace 4}{Right} ; octe (‡ partir d'octobree)
:*:octr::{Left}{BackSpace 4}{Right} ; octr (‡ partir d'octobrer)
:*:nov:: ; novembre
SendInput, embre
Return
:*:nove::{BackSpace 5} ; nove (‡ partir de novembree)
:*:nova::{Left}{BackSpace 5}{Right} ; nova (‡ partir de novembrea)
::dÈc::{BackSpace}embre ; dÈcembre

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Various :
;;;;;;;;;;;

:C:ab::{BackSpace 3}Arnaud BeLO. ; Arnaud BeLO.
:C:AB::{BackSpace}{Left}rnaud {Right}ELONOSCHKIN ; Arnaud BELONOSCHKIN
:*:mk:: ; Miuka
SendInput, {BackSpace 2}Miuka
Return
:C*:wp:: ; WordPress
SendInput, {BackSpace 2}WordPress
Return
:C*:WP:: ; WordPress
SendInput, {Left}ord{Right}ress
Return
:C*:wp-::{Left}{BackSpace 9}wp{Right} ; wp- (‡ partir de WordPress-)
:C*:WP-::{Left}{BackSpace 4}{Left}{BackSpace 3}{Right 2} ; WP- (‡ partir de WordPress-)
:*:mkw::{BackSpace} WYBORSKA ; Miuka WYBORSKA (‡ partir de Miukaw)
:*:b‡b:: ; Bande ‡ Balk
SendInput, {BackSpace}{Left}{BackSpace}Bande {Right} Balk
Return
:C*:bb::{Left}‹l{Right}‹l ; b‹lb‹l
:*:km.org::{Left 5}amea{Right}eahfilms{Right 4} ; kameameahfilms.org
:*:kmf::{BackSpace 3}Kamea Meah films ; Kamea Meah films
:*:b‡bs::{Left}{BackSpace 3}{Left}{BackSpace}{Left}{BackSpace 5}{Right 3} ; B‡Bs (‡ partir de Bande ‡ Balks)
:C*:alodb:: ; ¿ l'Ouest des Balkans
SendInput, {BackSpace}{Left}{BackSpace}{Left}{BackSpace}¿ {Right}'Ouest {Right}es Balkans
Return
:C*:alodb.org::{Left 4}{BackSpace 21}alodb{Right 4} ; alodb.org (‡ partir de ¿ l'Ouest des Balkans.org)
:*:slt::{Left 2}a{Right}u{Right} ; salut
:*:‡b::{Left}{BackSpace}¿ {Right}ientÙt ; ¿ bientÙt
:*:bs:: ; bises
SendInput, {Left}ise{Right}
Return
:*:bsr::{Left 2}{BackSpace 3}on{Right}oi{Right} ; bonsoir (‡ partir de bisesr)
:*:dgt::{Left 2}oi{Right 2} ; doigt
:*:frt::{Left}on{Right} ; front
::sg::{BackSpace}{Left}an{Right} ; sang
:C*:Bp::{Left}onne {Right}artie ; Bonne partie
:C*:bp::{Left}onne {Right}artie ; bonne partie
:C*:Gg::{Left}{BackSpace}Have a good {Right}ame ; Have a good game
:C*:gg::{Left 2}have a {Right}ood {Right}ame ; Have a good game
:C*:Hf::{Left}ave {Right}un ! ; Have fun !
:C*:hf::{Left}ave {Right}un ! ; have fun !
:*:drg::{Left}a{Right}on ; dragon
:C*:Mc::{Left}er{Right}i ; Merci
:C*:mc::{Left}er{Right}i ; merci
:C:cie::{BackSpace}{Left 2}ompagn{Right 2} ; compagnie
:*:thx::{BackSpace}anks ; thanks
:*:thks::{Left 3}{BackSpace}a{Right 3} ; thanks (‡ partir de thinks)
::sb::{BackSpace}{Left}ome{Right}ody ; somebody
:*:sthg::{Left 3}ome{Right 2}in{Right} ; something
:*:thg::{Left}in{Right} ; thing
:*:thk:: ; think
SendInput, {Left}in{Right}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

HOT_PrintHotstring(PRM_HotString, PRM_BackSpaceCount = 0) {

	If (GetKeyState("CapsLock", "P")) {
		StringGetPos, LOC_HotKey, A_ThisHotKey, :, L3
		LOC_HotKey := SubStr(A_ThisHotKey, LOC_HotKey)
		, LOC_BackSpaceCount := StrLen(LOC_HotKey) - 1 + PRM_BackSpaceCount
		SendInput, {BackSpace %LOC_BackSpaceCount%}%PRM_HotString%
/*		If (GetKeyState("Shift", "P")) {
			StringUpper, PRM_HotString, PRM_HotString
		}
*/
		SendInput, {Blind}{CapsLock Up}
	}
	Return
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; CapsLock acting like shift :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

HOT_CapsLock:
*CapsLock::
SetCapsLockState, Off
SetStoreCapslockMode, Off
SendInput, {Blind}{Shift DownTemp}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

*CapsLock Up::
;SetCapsLockState, Off
;SetStoreCapslockMode, Off
SendInput, {Blind}{Shift Up}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#Hotstring C

; Suffixe en A (ant) :
;;;;;;;;;;;;;;;;;;;;;;
:?*:aA::
HOT_PrintHotstring("nt")
Return
:?*:qA::
HOT_PrintHotstring("uant")
Return
:?*:bA::
:?*:cA::
:?*:dA::
:?*:eA::
:?*:ÈA::
:?*:ËA::
:?*:fA::
:?*:gA::
:?*:hA::
:?*:iA::
:?*:jA::
:?*:kA::
:?*:lA::
:?*:mA::
:?*:nA::
:?*:oA::
:?*:pA::
:?*:rA::
:?*:sA::
:?*:tA::
:?*:uA::
:?*:vA::
:?*:wA::
:?*:xA::
:?*:yA::
:?*:zA::
HOT_PrintHotstring("ant")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en AB (antable) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aAb::
:?*:qAb::
:?*:bAb::
:?*:cAb::
:?*:dAb::
:?*:eAb::
:?*:ÈAb::
:?*:ËAb::
:?*:fAb::
:?*:gAb::
:?*:hAb::
:?*:iAb::
:?*:jAb::
:?*:kAb::
:?*:lAb::
:?*:mAb::
:?*:nAb::
:?*:oAb::
:?*:pAb::
:?*:rAb::
:?*:sAb::
:?*:tAb::
:?*:uAb::
:?*:vAb::
:?*:wAb::
:?*:xAb::
:?*:yAb::
:?*:zAb::
HOT_PrintHotstring("able")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en ABT (antablement) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aAbt::
:?*:qAbt::
:?*:bAbt::
:?*:cAbt::
:?*:dAbt::
:?*:eAbt::
:?*:ÈAbt::
:?*:ËAbt::
:?*:fAbt::
:?*:gAbt::
:?*:hAbt::
:?*:iAbt::
:?*:jAbt::
:?*:kAbt::
:?*:lAbt::
:?*:mAbt::
:?*:nAbt::
:?*:oAbt::
:?*:pAbt::
:?*:rAbt::
:?*:sAbt::
:?*:tAbt::
:?*:uAbt::
:?*:vAbt::
:?*:wAbt::
:?*:xAbt::
:?*:yAbt::
:?*:zAbt::
HOT_PrintHotstring("ment")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en AE (antence) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aAe::
:?*:qAe::
:?*:bAe::
:?*:cAe::
:?*:dAe::
:?*:eAe::
:?*:ÈAe::
:?*:ËAe::
:?*:fAe::
:?*:gAe::
:?*:hAe::
:?*:iAe::
:?*:jAe::
:?*:kAe::
:?*:lAe::
:?*:mAe::
:?*:nAe::
:?*:oAe::
:?*:pAe::
:?*:rAe::
:?*:sAe::
:?*:tAe::
:?*:uAe::
:?*:vAe::
:?*:wAe::
:?*:xAe::
:?*:yAe::
:?*:zAe::
HOT_PrintHotstring("ence")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en AL (antelle) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aAl::
:?*:qAl::
:?*:bAl::
:?*:cAl::
:?*:dAl::
:?*:eAl::
:?*:ÈAl::
:?*:ËAl::
:?*:fAl::
:?*:gAl::
:?*:hAl::
:?*:iAl::
:?*:jAl::
:?*:kAl::
:?*:lAl::
:?*:mAl::
:?*:nAl::
:?*:oAl::
:?*:pAl::
:?*:rAl::
:?*:sAl::
:?*:tAl::
:?*:uAl::
:?*:vAl::
:?*:wAl::
:?*:xAl::
:?*:yAl::
:?*:zAl::
HOT_PrintHotstring("elle")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en ALT (antellement) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aAlt::
:?*:qAlt::
:?*:bAlt::
:?*:cAlt::
:?*:dAlt::
:?*:eAlt::
:?*:ÈAlt::
:?*:ËAlt::
:?*:fAlt::
:?*:gAlt::
:?*:hAlt::
:?*:iAlt::
:?*:jAlt::
:?*:kAlt::
:?*:lAlt::
:?*:mAlt::
:?*:nAlt::
:?*:oAlt::
:?*:pAlt::
:?*:rAlt::
:?*:sAlt::
:?*:tAlt::
:?*:uAlt::
:?*:vAlt::
:?*:wAlt::
:?*:xAlt::
:?*:yAlt::
:?*:zAlt::
HOT_PrintHotstring("ment")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en AM (antisme) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aAm::
:?*:qAm::
:?*:bAm::
:?*:cAm::
:?*:dAm::
:?*:eAm::
:?*:ÈAm::
:?*:ËAm::
:?*:fAm::
:?*:gAm::
:?*:hAm::
:?*:iAm::
:?*:jAm::
:?*:kAm::
:?*:lAm::
:?*:mAm::
:?*:nAm::
:?*:oAm::
:?*:pAm::
:?*:rAm::
:?*:sAm::
:?*:tAm::
:?*:uAm::
:?*:vAm::
:?*:wAm::
:?*:xAm::
:?*:yAm::
:?*:zAm::
HOT_PrintHotstring("isme")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en AN (antaison) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aAn::
:?*:qAn::
:?*:bAn::
:?*:cAn::
:?*:dAn::
:?*:eAn::
:?*:ÈAn::
:?*:ËAn::
:?*:fAn::
:?*:gAn::
:?*:hAn::
:?*:iAn::
:?*:jAn::
:?*:kAn::
:?*:lAn::
:?*:mAn::
:?*:nAn::
:?*:oAn::
:?*:pAn::
:?*:rAn::
:?*:sAn::
:?*:tAn::
:?*:uAn::
:?*:vAn::
:?*:wAn::
:?*:xAn::
:?*:yAn::
:?*:zAn::
HOT_PrintHotstring("aison")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en AO (antion) :
;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aAo::
:?*:qAo::
:?*:bAo::
:?*:cAo::
:?*:dAo::
:?*:eAo::
:?*:ÈAo::
:?*:ËAo::
:?*:fAo::
:?*:gAo::
:?*:hAo::
:?*:iAo::
:?*:jAo::
:?*:kAo::
:?*:lAo::
:?*:mAo::
:?*:nAo::
:?*:oAo::
:?*:pAo::
:?*:rAo::
:?*:sAo::
:?*:tAo::
:?*:uAo::
:?*:vAo::
:?*:wAo::
:?*:xAo::
:?*:yAo::
:?*:zAo::
HOT_PrintHotstring("ion")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en AQ (antique) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;
:*:Aq::
:?*:aAq::
:?*:qAq::
:?*:bAq::
:?*:cAq::
:?*:dAq::
:?*:eAq::
:?*:ÈAq::
:?*:ËAq::
:?*:fAq::
:?*:gAq::
:?*:hAq::
:?*:iAq::
:?*:jAq::
:?*:kAq::
:?*:lAq::
:?*:mAq::
:?*:nAq::
:?*:oAq::
:?*:pAq::
:?*:rAq::
:?*:sAq::
:?*:tAq::
:?*:uAq::
:?*:vAq::
:?*:wAq::
:?*:xAq::
:?*:yAq::
:?*:zAq::
HOT_PrintHotstring("ique")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en AQT (antiquement) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:*:Aqt:
:?*:aAqt::
:?*:qAqt::
:?*:bAqt::
:?*:cAqt::
:?*:dAqt::
:?*:eAqt::
:?*:ÈAqt::
:?*:ËAqt::
:?*:fAqt::
:?*:gAqt::
:?*:hAqt::
:?*:iAqt::
:?*:jAqt::
:?*:kAqt::
:?*:lAqt::
:?*:mAqt::
:?*:nAqt::
:?*:oAqt::
:?*:pAqt::
:?*:rAqt::
:?*:sAqt::
:?*:tAqt::
:?*:uAqt::
:?*:vAqt::
:?*:wAqt::
:?*:xAqt::
:?*:yAqt::
:?*:zAqt::
HOT_PrintHotstring("ment")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en AR (anteur) :
;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aAr::
:?*:qAr::
:?*:bAr::
:?*:cAr::
:?*:dAr::
:?*:eAr::
:?*:ÈAr::
:?*:ËAr::
:?*:fAr::
:?*:gAr::
:?*:hAr::
:?*:iAr::
:?*:jAr::
:?*:kAr::
:?*:lAr::
:?*:mAr::
:?*:nAr::
:?*:oAr::
:?*:pAr::
:?*:rAr::
:?*:sAr::
:?*:tAr::
:?*:uAr::
:?*:vAr::
:?*:wAr::
:?*:xAr::
:?*:yAr::
:?*:zAr::
HOT_PrintHotstring("eur")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en AS (antesse) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aAs::
:?*:qAs::
:?*:bAs::
:?*:cAs::
:?*:dAs::
:?*:eAs::
:?*:ÈAs::
:?*:ËAs::
:?*:fAs::
:?*:gAs::
:?*:hAs::
:?*:iAs::
:?*:jAs::
:?*:kAs::
:?*:lAs::
:?*:mAs::
:?*:nAs::
:?*:oAs::
:?*:pAs::
:?*:rAs::
:?*:sAs::
:?*:tAs::
:?*:uAs::
:?*:vAs::
:?*:wAs::
:?*:xAs::
:?*:yAs::
:?*:zAs::
HOT_PrintHotstring("esse")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en AT (antement) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aAt::
:?*:qAt::
:?*:bAt::
:?*:cAt::
:?*:dAt::
:?*:eAt::
:?*:ÈAt::
:?*:ËAt::
:?*:fAt::
:?*:gAt::
:?*:hAt::
:?*:iAt::
:?*:jAt::
:?*:kAt::
:?*:lAt::
:?*:mAt::
:?*:nAt::
:?*:oAt::
:?*:pAt::
:?*:rAt::
:?*:sAt::
:?*:tAt::
:?*:uAt::
:?*:vAt::
:?*:wAt::
:?*:xAt::
:?*:yAt::
:?*:zAt::
HOT_PrintHotstring("ement")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en AY (antille) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;
:*:Ay::
:?*:aAy::
:?*:qAy::
:?*:bAy::
:?*:cAy::
:?*:dAy::
:?*:eAy::
:?*:ÈAy::
:?*:ËAy::
:?*:fAy::
:?*:gAy::
:?*:hAy::
:?*:iAy::
:?*:jAy::
:?*:kAy::
:?*:lAy::
:?*:mAy::
:?*:nAy::
:?*:oAy::
:?*:pAy::
:?*:rAy::
:?*:sAy::
:?*:tAy::
:?*:uAy::
:?*:vAy::
:?*:wAy::
:?*:xAy::
:?*:yAy::
:?*:zAy::
HOT_PrintHotstring("ille")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en AZ (anteuse) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aAz::
:?*:qAz::
:?*:bAz::
:?*:cAz::
:?*:dAz::
:?*:eAz::
:?*:ÈAz::
:?*:ËAz::
:?*:fAz::
:?*:gAz::
:?*:hAz::
:?*:iAz::
:?*:jAz::
:?*:kAz::
:?*:lAz::
:?*:mAz::
:?*:nAz::
:?*:oAz::
:?*:pAz::
:?*:rAz::
:?*:sAz::
:?*:tAz::
:?*:uAz::
:?*:vAz::
:?*:wAz::
:?*:xAz::
:?*:yAz::
:?*:zAz::
HOT_PrintHotstring("euse")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en AZT (anteusement) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aAzt::
:?*:qAzt::
:?*:bAzt::
:?*:cAzt::
:?*:dAzt::
:?*:eAzt::
:?*:ÈAzt::
:?*:ËAzt::
:?*:fAzt::
:?*:gAzt::
:?*:hAzt::
:?*:iAzt::
:?*:jAzt::
:?*:kAzt::
:?*:lAzt::
:?*:mAzt::
:?*:nAzt::
:?*:oAzt::
:?*:pAzt::
:?*:rAzt::
:?*:sAzt::
:?*:tAzt::
:?*:uAzt::
:?*:vAzt::
:?*:wAzt::
:?*:xAzt::
:?*:yAzt::
:?*:zAzt::
HOT_PrintHotstring("ment")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en B (able) :
;;;;;;;;;;;;;;;;;;;;;;;
:?*:aB::
HOT_PrintHotstring("ble")
Return
:?*:qB::
HOT_PrintHotstring("uable")
Return
:?*:bB::
:?*:cB::
:?*:dB::
:?*:eB::
:?*:ÈB::
:?*:ËB::
:?*:fB::
:?*:gB::
:?*:hB::
:?*:iB::
:?*:jB::
:?*:kB::
:?*:lB::
:?*:mB::
:?*:nB::
:?*:oB::
:?*:pB::
:?*:rB::
:?*:sB::
:?*:tB::
:?*:uB::
:?*:vB::
:?*:wB::
:?*:xB::
:?*:yB::
:?*:zB::
HOT_PrintHotstring("able")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en BA (ablant) :
;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aBa::
:?*:qBa::
:?*:bBa::
:?*:cBa::
:?*:dBa::
:?*:eBa::
:?*:ÈBa::
:?*:ËBa::
:?*:fBa::
:?*:gBa::
:?*:hBa::
:?*:iBa::
:?*:jBa::
:?*:kBa::
:?*:lBa::
:?*:mBa::
:?*:nBa::
:?*:oBa::
:?*:pBa::
:?*:rBa::
:?*:sBa::
:?*:tBa::
:?*:uBa::
:?*:vBa::
:?*:wBa::
:?*:xBa::
:?*:yBa::
:?*:zBa::
HoT_PrintHotstring("ant", 1)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en BE (ablence) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aBe::
:?*:qBe::
:?*:bBe::
:?*:cBe::
:?*:dBe::
:?*:eBe::
:?*:ÈBe::
:?*:ËBe::
:?*:fBe::
:?*:gBe::
:?*:hBe::
:?*:iBe::
:?*:jBe::
:?*:kBe::
:?*:lBe::
:?*:mBe::
:?*:nBe::
:?*:oBe::
:?*:pBe::
:?*:rBe::
:?*:sBe::
:?*:tBe::
:?*:uBe::
:?*:vBe::
:?*:wBe::
:?*:xBe::
:?*:yBe::
:?*:zBe::
HOT_PrintHotstring("nce")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en BH (ablechie) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aBh::
:?*:qBh::
:?*:bBh::
:?*:cBh::
:?*:dBh::
:?*:eBh::
:?*:ÈBh::
:?*:ËBh::
:?*:fBh::
:?*:gBh::
:?*:hBh::
:?*:iBh::
:?*:jBh::
:?*:kBh::
:?*:lBh::
:?*:mBh::
:?*:nBh::
:?*:oBh::
:?*:pBh::
:?*:rBh::
:?*:sBh::
:?*:tBh::
:?*:uBh::
:?*:vBh::
:?*:wBh::
:?*:xBh::
:?*:yBh::
:?*:zBh::
HOT_PrintHotstring("chie")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en BJ (ablegie) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aBj::
:?*:qBj::
:?*:bBj::
:?*:cBj::
:?*:dBj::
:?*:eBj::
:?*:ÈBj::
:?*:ËBj::
:?*:fBj::
:?*:gBj::
:?*:hBj::
:?*:iBj::
:?*:jBj::
:?*:kBj::
:?*:lBj::
:?*:mBj::
:?*:nBj::
:?*:oBj::
:?*:pBj::
:?*:rBj::
:?*:sBj::
:?*:tBj::
:?*:uBj::
:?*:vBj::
:?*:wBj::
:?*:xBj::
:?*:yBj::
:?*:zBj::
HOT_PrintHotstring("gie")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en BM (ablisme) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aBm::
:?*:qBm::
:?*:bBm::
:?*:cBm::
:?*:dBm::
:?*:eBm::
:?*:ÈBm::
:?*:ËBm::
:?*:fBm::
:?*:gBm::
:?*:hBm::
:?*:iBm::
:?*:jBm::
:?*:kBm::
:?*:lBm::
:?*:mBm::
:?*:nBm::
:?*:oBm::
:?*:pBm::
:?*:rBm::
:?*:sBm::
:?*:tBm::
:?*:uBm::
:?*:vBm::
:?*:wBm::
:?*:xBm::
:?*:yBm::
:?*:zBm::
HOT_PrintHotstring("isme", 1)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en BN (ablaison) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aBn::
:?*:qBn::
:?*:bBn::
:?*:cBn::
:?*:dBn::
:?*:eBn::
:?*:ÈBn::
:?*:ËBn::
:?*:fBn::
:?*:gBn::
:?*:hBn::
:?*:iBn::
:?*:jBn::
:?*:kBn::
:?*:lBn::
:?*:mBn::
:?*:nBn::
:?*:oBn::
:?*:pBn::
:?*:rBn::
:?*:sBn::
:?*:tBn::
:?*:uBn::
:?*:vBn::
:?*:wBn::
:?*:xBn::
:?*:yBn::
:?*:zBn::
HOT_PrintHotstring("aison", 1)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en BQ (ablique) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aBq::
:?*:qBq::
:?*:bBq::
:?*:cBq::
:?*:dBq::
:?*:eBq::
:?*:ÈBq::
:?*:ËBq::
:?*:fBq::
:?*:gBq::
:?*:hBq::
:?*:iBq::
:?*:jBq::
:?*:kBq::
:?*:lBq::
:?*:mBq::
:?*:nBq::
:?*:oBq::
:?*:pBq::
:?*:rBq::
:?*:sBq::
:?*:tBq::
:?*:uBq::
:?*:vBq::
:?*:wBq::
:?*:xBq::
:?*:yBq::
:?*:zBq::
HOT_PrintHotstring("ique", 1)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en BQT (abliquement) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aBqt::
:?*:qBqt::
:?*:bBqt::
:?*:cBqt::
:?*:dBqt::
:?*:eBqt::
:?*:ÈBqt::
:?*:ËBqt::
:?*:fBqt::
:?*:gBqt::
:?*:hBqt::
:?*:iBqt::
:?*:jBqt::
:?*:kBqt::
:?*:lBqt::
:?*:mBqt::
:?*:nBqt::
:?*:oBqt::
:?*:pBqt::
:?*:rBqt::
:?*:sBqt::
:?*:tBqt::
:?*:uBqt::
:?*:vBqt::
:?*:wBqt::
:?*:xBqt::
:?*:yBqt::
:?*:zBqt::
HOT_PrintHotstring("ment")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en BR (ableur) :
;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aBr::
:?*:qBr::
:?*:bBr::
:?*:cBr::
:?*:dBr::
:?*:eBr::
:?*:ÈBr::
:?*:ËBr::
:?*:fBr::
:?*:gBr::
:?*:hBr::
:?*:iBr::
:?*:jBr::
:?*:kBr::
:?*:lBr::
:?*:mBr::
:?*:nBr::
:?*:oBr::
:?*:pBr::
:?*:rBr::
:?*:sBr::
:?*:tBr::
:?*:uBr::
:?*:vBr::
:?*:wBr::
:?*:xBr::
:?*:yBr::
:?*:zBr::
HOT_PrintHotstring("ur")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en BS (ablesse) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aBs::
:?*:qBs::
:?*:bBs::
:?*:cBs::
:?*:dBs::
:?*:eBs::
:?*:ÈBs::
:?*:ËBs::
:?*:fBs::
:?*:gBs::
:?*:hBs::
:?*:iBs::
:?*:jBs::
:?*:kBs::
:?*:lBs::
:?*:mBs::
:?*:nBs::
:?*:oBs::
:?*:pBs::
:?*:rBs::
:?*:sBs::
:?*:tBs::
:?*:uBs::
:?*:vBs::
:?*:wBs::
:?*:xBs::
:?*:yBs::
:?*:zBs::
HOT_PrintHotstring("sse")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en BT (ablement) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aBt::
:?*:qBt::
:?*:bBt::
:?*:cBt::
:?*:dBt::
:?*:eBt::
:?*:ÈBt::
:?*:ËBt::
:?*:fBt::
:?*:gBt::
:?*:hBt::
:?*:iBt::
:?*:jBt::
:?*:kBt::
:?*:lBt::
:?*:mBt::
:?*:nBt::
:?*:oBt::
:?*:pBt::
:?*:rBt::
:?*:sBt::
:?*:tBt::
:?*:uBt::
:?*:vBt::
:?*:wBt::
:?*:xBt::
:?*:yBt::
:?*:zBt::
HOT_PrintHotstring("ment")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en BZ (ableuse) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aBz::
:?*:qBz::
:?*:bBz::
:?*:cBz::
:?*:dBz::
:?*:eBz::
:?*:ÈBz::
:?*:ËBz::
:?*:fBz::
:?*:gBz::
:?*:hBz::
:?*:iBz::
:?*:jBz::
:?*:kBz::
:?*:lBz::
:?*:mBz::
:?*:nBz::
:?*:oBz::
:?*:pBz::
:?*:rBz::
:?*:sBz::
:?*:tBz::
:?*:uBz::
:?*:vBz::
:?*:wBz::
:?*:xBz::
:?*:yBz::
:?*:zBz::
HOT_PrintHotstring("use")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en E (ence) :
;;;;;;;;;;;;;;;;;;;;;;;
:?*:qE::
HOT_PrintHotstring("uence")
Return
:?*:aE::
:?*:bE::
:?*:cE::
:?*:dE::
:?*:ÈE::
:?*:ËE::
:?*:fE::
:?*:gE::
:?*:hE::
:?*:iE::
:?*:jE::
:?*:kE::
:?*:lE::
:?*:mE::
:?*:nE::
:?*:oE::
:?*:pE::
:?*:rE::
:?*:sE::
:?*:tE::
:?*:uE::
:?*:vE::
:?*:wE::
:?*:xE::
:?*:yE::
:?*:zE::
HOT_PrintHotstring("ence")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en EB (enÁable) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:qEb::
:?*:aEb::
:?*:bEb::
:?*:cEb::
:?*:dEb::
:?*:ÈEb::
:?*:ËEb::
:?*:fEb::
:?*:gEb::
:?*:hEb::
:?*:iEb::
:?*:jEb::
:?*:kEb::
:?*:lEb::
:?*:mEb::
:?*:nEb::
:?*:oEb::
:?*:pEb::
:?*:rEb::
:?*:sEb::
:?*:tEb::
:?*:uEb::
:?*:vEb::
:?*:wEb::
:?*:xEb::
:?*:yEb::
:?*:zEb::
HOT_PrintHotstring("Áable", 2)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en EBT (enÁablement) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:qEbt::
:?*:aEbt::
:?*:bEbt::
:?*:cEbt::
:?*:dEbt::
:?*:ÈEbt::
:?*:ËEbt::
:?*:fEbt::
:?*:gEbt::
:?*:hEbt::
:?*:iEbt::
:?*:jEbt::
:?*:kEbt::
:?*:lEbt::
:?*:mEbt::
:?*:nEbt::
:?*:oEbt::
:?*:pEbt::
:?*:rEbt::
:?*:sEbt::
:?*:tEbt::
:?*:uEbt::
:?*:vEbt::
:?*:wEbt::
:?*:xEbt::
:?*:yEbt::
:?*:zEbt::
HOT_PrintHotstring("ment")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en EL (encelle) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:qEl::
:?*:aEl::
:?*:bEl::
:?*:cEl::
:?*:dEl::
:?*:ÈEl::
:?*:ËEl::
:?*:fEl::
:?*:gEl::
:?*:hEl::
:?*:iEl::
:?*:jEl::
:?*:kEl::
:?*:lEl::
:?*:mEl::
:?*:nEl::
:?*:oEl::
:?*:pEl::
:?*:rEl::
:?*:sEl::
:?*:tEl::
:?*:uEl::
:?*:vEl::
:?*:wEl::
:?*:xEl::
:?*:yEl::
:?*:zEl::
HOT_PrintHotstring("lle")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en ELT (encellement) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:qElt::
:?*:aElt::
:?*:bElt::
:?*:cElt::
:?*:dElt::
:?*:ÈElt::
:?*:ËElt::
:?*:fElt::
:?*:gElt::
:?*:hElt::
:?*:iElt::
:?*:jElt::
:?*:kElt::
:?*:lElt::
:?*:mElt::
:?*:nElt::
:?*:oElt::
:?*:pElt::
:?*:rElt::
:?*:sElt::
:?*:tElt::
:?*:uElt::
:?*:vElt::
:?*:wElt::
:?*:xElt::
:?*:yElt::
:?*:zElt::
HOT_PrintHotstring("ment")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en EM (encisme) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:qEm::
:?*:aEm::
:?*:bEm::
:?*:cEm::
:?*:dEm::
:?*:ÈEm::
:?*:ËEm::
:?*:fEm::
:?*:gEm::
:?*:hEm::
:?*:iEm::
:?*:jEm::
:?*:kEm::
:?*:lEm::
:?*:mEm::
:?*:nEm::
:?*:oEm::
:?*:pEm::
:?*:rEm::
:?*:sEm::
:?*:tEm::
:?*:uEm::
:?*:vEm::
:?*:wEm::
:?*:xEm::
:?*:yEm::
:?*:zEm::
HOT_PrintHotstring("isme", 1)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en EQ (encique) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:qEq::
:?*:aEq::
:?*:bEq::
:?*:cEq::
:?*:dEq::
:?*:ÈEq::
:?*:ËEq::
:?*:fEq::
:?*:gEq::
:?*:hEq::
:?*:iEq::
:?*:jEq::
:?*:kEq::
:?*:lEq::
:?*:mEq::
:?*:nEq::
:?*:oEq::
:?*:pEq::
:?*:rEq::
:?*:sEq::
:?*:tEq::
:?*:uEq::
:?*:vEq::
:?*:wEq::
:?*:xEq::
:?*:yEq::
:?*:zEq::
HOT_PrintHotstring("ique", 1)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en ER (enceur) :
;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:qEr::
:?*:aEr::
:?*:bEr::
:?*:cEr::
:?*:dEr::
:?*:ÈEr::
:?*:ËEr::
:?*:fEr::
:?*:gEr::
:?*:hEr::
:?*:iEr::
:?*:jEr::
:?*:kEr::
:?*:lEr::
:?*:mEr::
:?*:nEr::
:?*:oEr::
:?*:pEr::
:?*:rEr::
:?*:sEr::
:?*:tEr::
:?*:uEr::
:?*:vEr::
:?*:wEr::
:?*:xEr::
:?*:yEr::
:?*:zEr::
HOT_PrintHotstring("ur")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en ES (encesse) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:qEs::
:?*:aEs::
:?*:bEs::
:?*:cEs::
:?*:dEs::
:?*:ÈEs::
:?*:ËEs::
:?*:fEs::
:?*:gEs::
:?*:hEs::
:?*:iEs::
:?*:jEs::
:?*:kEs::
:?*:lEs::
:?*:mEs::
:?*:nEs::
:?*:oEs::
:?*:pEs::
:?*:rEs::
:?*:sEs::
:?*:tEs::
:?*:uEs::
:?*:vEs::
:?*:wEs::
:?*:xEs::
:?*:yEs::
:?*:zEs::
HOT_PrintHotstring("sse")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en ET (encement) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:qEt::
:?*:aEt::
:?*:bEt::
:?*:cEt::
:?*:dEt::
:?*:ÈEt::
:?*:ËEt::
:?*:fEt::
:?*:gEt::
:?*:hEt::
:?*:iEt::
:?*:jEt::
:?*:kEt::
:?*:lEt::
:?*:mEt::
:?*:nEt::
:?*:oEt::
:?*:pEt::
:?*:rEt::
:?*:sEt::
:?*:tEt::
:?*:uEt::
:?*:vEt::
:?*:wEt::
:?*:xEt::
:?*:yEt::
:?*:zEt::
HOT_PrintHotstring("ment")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en EZ (enceuse) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:qEz::
:?*:aEz::
:?*:bEz::
:?*:cEz::
:?*:dEz::
:?*:ÈEz::
:?*:ËEz::
:?*:fEz::
:?*:gEz::
:?*:hEz::
:?*:iEz::
:?*:jEz::
:?*:kEz::
:?*:lEz::
:?*:mEz::
:?*:nEz::
:?*:oEz::
:?*:pEz::
:?*:rEz::
:?*:sEz::
:?*:tEz::
:?*:uEz::
:?*:vEz::
:?*:wEz::
:?*:xEz::
:?*:yEz::
:?*:zEz::
HOT_PrintHotstring("use")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en G (age) :
;;;;;;;;;;;;;;;;;;;;;;
:?*:aG::
HOT_PrintHotstring("ge")
Return
:?*:qG::
HOT_PrintHotstring("uage")
Return
:?*:bG::
:?*:cG::
:?*:dG::
:?*:eG::
:?*:ÈG::
:?*:ËG::
:?*:fG::
:?*:gG::
:?*:hG::
:?*:iG::
:?*:ÓG::
:?*:jG::
:?*:kG::
:?*:lG::
:?*:mG::
:?*:nG::
:?*:oG::
:?*:pG::
:?*:rG::
:?*:sG::
:?*:tG::
:?*:uG::
:?*:vG::
:?*:wG::
:?*:xG::
:?*:yG::
:?*:zG::
HOT_PrintHotstring("age")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en GB (agable) :
;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aGb::
:?*:bGb::
:?*:cGb::
:?*:dGb::
:?*:eGb::
:?*:ÈGb::
:?*:ËGb::
:?*:fGb::
:?*:gGb::
:?*:hGb::
:?*:iGb::
:?*:ÓGb::
:?*:jGb::
:?*:kGb::
:?*:lGb::
:?*:mGb::
:?*:nGb::
:?*:oGb::
:?*:pGb::
:?*:qGb::
:?*:rGb::
:?*:sGb::
:?*:tGb::
:?*:uGb::
:?*:vGb::
:?*:wGb::
:?*:xGb::
:?*:yGb::
:?*:zGb::
HOT_PrintHotstring("able", 1)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en GBA (agablant) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aGba::
:?*:bGba::
:?*:cGba::
:?*:dGba::
:?*:eGba::
:?*:ÈGba::
:?*:ËGba::
:?*:fGba::
:?*:gGba::
:?*:hGba::
:?*:iGba::
:?*:ÓGba::
:?*:jGba::
:?*:kGba::
:?*:lGba::
:?*:mGba::
:?*:nGba::
:?*:oGba::
:?*:pGba::
:?*:qGba::
:?*:rGba::
:?*:sGba::
:?*:tGba::
:?*:uGba::
:?*:vGba::
:?*:wGba::
:?*:xGba::
:?*:yGba::
:?*:zGba::
HOT_PrintHotstring("ant", 1)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en GBT (agablement) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aGbt::
:?*:bGbt::
:?*:cGbt::
:?*:dGbt::
:?*:eGbt::
:?*:ÈGbt::
:?*:ËGbt::
:?*:fGbt::
:?*:gGbt::
:?*:hGbt::
:?*:iGbt::
:?*:ÓGbt::
:?*:jGbt::
:?*:kGbt::
:?*:lGbt::
:?*:mGbt::
:?*:nGbt::
:?*:oGbt::
:?*:pGbt::
:?*:qGbt::
:?*:rGbt::
:?*:sGbt::
:?*:tGbt::
:?*:uGbt::
:?*:vGbt::
:?*:wGbt::
:?*:xGbt::
:?*:yGbt::
:?*:zGbt::
HOT_PrintHotstring("ment")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en GE (agence) :
;;;;;;;;;;;;;;;;;;;;;;;;;;
:*:Ge::
:?*:aGe::
:?*:bGe::
:?*:cGe::
:?*:dGe::
:?*:eGe::
:?*:ÈGe::
:?*:ËGe::
:?*:fGe::
:?*:gGe::
:?*:hGe::
:?*:iGe::
:?*:ÓGe::
:?*:jGe::
:?*:kGe::
:?*:lGe::
:?*:mGe::
:?*:nGe::
:?*:oGe::
:?*:pGe::
:?*:qGe::
:?*:rGe::
:?*:sGe::
:?*:tGe::
:?*:uGe::
:?*:vGe::
:?*:wGe::
:?*:xGe::
:?*:yGe::
:?*:zGe::
HOT_PrintHotstring("nce")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en GER (agenceur) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:*:Ger::
:?*:aGer::
:?*:bGer::
:?*:cGer::
:?*:dGer::
:?*:eGer::
:?*:ÈGer::
:?*:ËGer::
:?*:fGer::
:?*:gGer::
:?*:hGer::
:?*:iGer::
:?*:ÓGer::
:?*:jGer::
:?*:kGer::
:?*:lGer::
:?*:mGer::
:?*:nGer::
:?*:oGer::
:?*:pGer::
:?*:qGer::
:?*:rGer::
:?*:sGer::
:?*:tGer::
:?*:uGer::
:?*:vGer::
:?*:wGer::
:?*:xGer::
:?*:yGer::
:?*:zGer::
HOT_PrintHotstring("ur")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en GET (agencement) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:*:Get::
:?*:aGet::
:?*:bGet::
:?*:cGet::
:?*:dGet::
:?*:eGet::
:?*:ÈGet::
:?*:ËGet::
:?*:fGet::
:?*:gGet::
:?*:hGet::
:?*:iGet::
:?*:ÓGet::
:?*:jGet::
:?*:kGet::
:?*:lGet::
:?*:mGet::
:?*:nGet::
:?*:oGet::
:?*:pGet::
:?*:qGet::
:?*:rGet::
:?*:sGet::
:?*:tGet::
:?*:uGet::
:?*:vGet::
:?*:wGet::
:?*:xGet::
:?*:yGet::
:?*:zGet::
HOT_PrintHotstring("ment")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en GEZ (agenceuse) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:*:Gez::
:?*:aGez::
:?*:bGez::
:?*:cGez::
:?*:dGez::
:?*:eGez::
:?*:ÈGez::
:?*:ËGez::
:?*:fGez::
:?*:gGez::
:?*:hGez::
:?*:iGez::
:?*:ÓGez::
:?*:jGez::
:?*:kGez::
:?*:lGez::
:?*:mGez::
:?*:nGez::
:?*:oGez::
:?*:pGez::
:?*:qGez::
:?*:rGez::
:?*:sGez::
:?*:tGez::
:?*:uGez::
:?*:vGez::
:?*:wGez::
:?*:xGez::
:?*:yGez::
:?*:zGez::
HOT_PrintHotstring("use")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en GL (agelle) :
;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aGl::
:?*:bGl::
:?*:cGl::
:?*:dGl::
:?*:eGl::
:?*:ÈGl::
:?*:ËGl::
:?*:fGl::
:?*:gGl::
:?*:hGl::
:?*:iGl::
:?*:ÓGl::
:?*:jGl::
:?*:kGl::
:?*:lGl::
:?*:mGl::
:?*:nGl::
:?*:oGl::
:?*:pGl::
:?*:qGl::
:?*:rGl::
:?*:sGl::
:?*:tGl::
:?*:uGl::
:?*:vGl::
:?*:wGl::
:?*:xGl::
:?*:yGl::
:?*:zGl::
HOT_PrintHotstring("lle")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en GM (agisme) :
;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aGm::
:?*:bGm::
:?*:cGm::
:?*:dGm::
:?*:eGm::
:?*:ÈGm::
:?*:ËGm::
:?*:fGm::
:?*:gGm::
:?*:hGm::
:?*:iGm::
:?*:ÓGm::
:?*:jGm::
:?*:kGm::
:?*:lGm::
:?*:mGm::
:?*:nGm::
:?*:oGm::
:?*:pGm::
:?*:qGm::
:?*:rGm::
:?*:sGm::
:?*:tGm::
:?*:uGm::
:?*:vGm::
:?*:wGm::
:?*:xGm::
:?*:yGm::
:?*:zGm::
HOT_PrintHotstring("isme", 1)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en GQ (agique) :
;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aGq::
:?*:bGq::
:?*:cGq::
:?*:dGq::
:?*:eGq::
:?*:ÈGq::
:?*:ËGq::
:?*:fGq::
:?*:gGq::
:?*:hGq::
:?*:iGq::
:?*:ÓGq::
:?*:jGq::
:?*:kGq::
:?*:lGq::
:?*:mGq::
:?*:nGq::
:?*:oGq::
:?*:pGq::
:?*:qGq::
:?*:rGq::
:?*:sGq::
:?*:tGq::
:?*:uGq::
:?*:vGq::
:?*:wGq::
:?*:xGq::
:?*:yGq::
:?*:zGq::
HOT_PrintHotstring("ique", 1)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en GQT (agiquement) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aGqt::
:?*:bGqt::
:?*:cGqt::
:?*:dGqt::
:?*:eGqt::
:?*:ÈGqt::
:?*:ËGqt::
:?*:fGqt::
:?*:gGqt::
:?*:hGqt::
:?*:iGqt::
:?*:ÓGqt::
:?*:jGqt::
:?*:kGqt::
:?*:lGqt::
:?*:mGqt::
:?*:nGqt::
:?*:oGqt::
:?*:pGqt::
:?*:qGqt::
:?*:rGqt::
:?*:sGqt::
:?*:tGqt::
:?*:uGqt::
:?*:vGqt::
:?*:wGqt::
:?*:xGqt::
:?*:yGqt::
:?*:zGqt::
HOT_PrintHotstring("ment")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en GR (ageur) :
;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aGr::
:?*:bGr::
:?*:cGr::
:?*:dGr::
:?*:eGr::
:?*:ÈGr::
:?*:ËGr::
:?*:fGr::
:?*:gGr::
:?*:hGr::
:?*:iGr::
:?*:ÓGr::
:?*:jGr::
:?*:kGr::
:?*:lGr::
:?*:mGr::
:?*:nGr::
:?*:oGr::
:?*:pGr::
:?*:qGr::
:?*:rGr::
:?*:sGr::
:?*:tGr::
:?*:uGr::
:?*:vGr::
:?*:wGr::
:?*:xGr::
:?*:yGr::
:?*:zGr::
HOT_PrintHotstring("ur")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en GS (agesse) :
;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aGs::
:?*:bGs::
:?*:cGs::
:?*:dGs::
:?*:eGs::
:?*:ÈGs::
:?*:ËGs::
:?*:fGs::
:?*:gGs::
:?*:hGs::
:?*:iGs::
:?*:ÓGs::
:?*:jGs::
:?*:kGs::
:?*:lGs::
:?*:mGs::
:?*:nGs::
:?*:oGs::
:?*:pGs::
:?*:qGs::
:?*:rGs::
:?*:sGs::
:?*:tGs::
:?*:uGs::
:?*:vGs::
:?*:wGs::
:?*:xGs::
:?*:yGs::
:?*:zGs::
HOT_PrintHotstring("sse")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en GT (agement) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aGt::
:?*:bGt::
:?*:cGt::
:?*:dGt::
:?*:eGt::
:?*:ÈGt::
:?*:ËGt::
:?*:fGt::
:?*:gGt::
:?*:hGt::
:?*:iGt::
:?*:ÓGt::
:?*:jGt::
:?*:kGt::
:?*:lGt::
:?*:mGt::
:?*:nGt::
:?*:oGt::
:?*:pGt::
:?*:qGt::
:?*:rGt::
:?*:sGt::
:?*:tGt::
:?*:uGt::
:?*:vGt::
:?*:wGt::
:?*:xGt::
:?*:yGt::
:?*:zGt::
HOT_PrintHotstring("ment")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en GZ (ageuse) :
;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aGz::
:?*:bGz::
:?*:cGz::
:?*:dGz::
:?*:eGz::
:?*:ÈGz::
:?*:ËGz::
:?*:fGz::
:?*:gGz::
:?*:hGz::
:?*:iGz::
:?*:ÓGz::
:?*:jGz::
:?*:kGz::
:?*:lGz::
:?*:mGz::
:?*:nGz::
:?*:oGz::
:?*:pGz::
:?*:qGz::
:?*:rGz::
:?*:sGz::
:?*:tGz::
:?*:uGz::
:?*:vGz::
:?*:wGz::
:?*:xGz::
:?*:yGz::
:?*:zGz::
HOT_PrintHotstring("use")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en H (chie) :
;;;;;;;;;;;;;;;;;;;;;;;
:?*:aH::
:?*:eH::
:?*:ÈH::
:?*:ËH::
:?*:iH::
:?*:lH::
:?*:nH::
:?*:oH::
:?*:rH::
:?*:sH::
:?*:tH::
:?*:uH::
:?*:yH::
HOT_PrintHotstring("chie")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en HA (chiant) :
;;;;;;;;;;;;;;;;;;;;;;;;;;
:*:Ha::
:?*:aHa::
:?*:eHa::
:?*:ÈHa::
:?*:ËHa::
:?*:iHa::
:?*:lHa::
:?*:nHa::
:?*:oHa::
:?*:rHa::
:?*:sHa::
:?*:tHa::
:?*:uHa::
:?*:yHa::
HoT_PrintHotstring("ant", 1)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en HB (chable) :
;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aHb::
:?*:eHb::
:?*:ÈHb::
:?*:ËHb::
:?*:iHb::
:?*:lHb::
:?*:nHb::
:?*:oHb::
:?*:rHb::
:?*:sHb::
:?*:tHb::
:?*:uHb::
:?*:yHb::
HOT_PrintHotstring("able", 2)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en HM (chisme) :
;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aHm::
:?*:eHm::
:?*:ÈHm::
:?*:ËHm::
:?*:iHm::
:?*:lHm::
:?*:nHm::
:?*:oHm::
:?*:rHm::
:?*:sHm::
:?*:tHm::
:?*:uHm::
:?*:yHm::
HOT_PrintHotstring("sme", 1)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en HQ (chique) :
;;;;;;;;;;;;;;;;;;;;;;;;;;
:*:Hq::
:?*:aHq::
:?*:eHq::
:?*:ÈHq::
:?*:ËHq::
:?*:iHq::
:?*:lHq::
:?*:nHq::
:?*:oHq::
:?*:rHq::
:?*:sHq::
:?*:tHq::
:?*:uHq::
:?*:yHq::
HOT_PrintHotstring("que", 1)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en HT (chiement) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:*:Ht::
:?*:aHt::
:?*:eHt::
:?*:ÈHt::
:?*:ËHt::
:?*:iHt::
:?*:lHt::
:?*:nHt::
:?*:oHt::
:?*:rHt::
:?*:sHt::
:?*:tHt::
:?*:uHt::
:?*:yHt::
HOT_PrintHotstring("ment")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en J (gie) :
;;;;;;;;;;;;;;;;;;;;;;
:?*:aJ::
:?*:eJ::
:?*:ÈJ::
:?*:ËJ::
:?*:iJ::
:?*:lJ::
:?*:nJ::
:?*:oJ::
:?*:rJ::
:?*:sJ::
:?*:uJ::
:?*:yJ::
HOT_PrintHotstring("gie")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en JB (giable) :
;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aJb::
:?*:eJb::
:?*:ÈJb::
:?*:ËJb::
:?*:iJb::
:?*:lJb::
:?*:nJb::
:?*:oJb::
:?*:rJb::
:?*:sJb::
:?*:uJb::
:?*:yJb::
HOT_PrintHotstring("able", 1)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en JBT (giablement) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aJbt::
:?*:eJbt::
:?*:ÈJbt::
:?*:ËJbt::
:?*:iJbt::
:?*:lJbt::
:?*:nJbt::
:?*:oJbt::
:?*:rJbt::
:?*:sJbt::
:?*:uJbt::
:?*:yJbt::
HOT_PrintHotstring("ment", 1)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en JE (gience) :
;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aJe::
:?*:eJe::
:?*:ÈJe::
:?*:ËJe::
:?*:iJe::
:?*:lJe::
:?*:nJe::
:?*:oJe::
:?*:rJe::
:?*:sJe::
:?*:uJe::
:?*:yJe::
HOT_PrintHotstring("nce")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en JL (gielle) :
;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aJl::
:?*:eJl::
:?*:ÈJl::
:?*:ËJl::
:?*:iJl::
:?*:lJl::
:?*:nJl::
:?*:oJl::
:?*:rJl::
:?*:sJl::
:?*:uJl::
:?*:yJl::
HOT_PrintHotstring("lle")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en JM (gisme) :
;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aJm::
:?*:eJm::
:?*:ÈJm::
:?*:ËJm::
:?*:iJm::
:?*:lJm::
:?*:nJm::
:?*:oJm::
:?*:rJm::
:?*:sJm::
:?*:uJm::
:?*:yJm::
HOT_PrintHotstring("sme", 1)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en JO (gition) :
;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aJo::
:?*:eJo::
:?*:ÈJo::
:?*:ËJo::
:?*:iJo::
:?*:lJo::
:?*:nJo::
:?*:oJo::
:?*:rJo::
:?*:sJo::
:?*:uJo::
:?*:yJo::
HOT_PrintHotstring("tion", 1)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en JQ (gique) :
;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aJq::
:?*:eJq::
:?*:ÈJq::
:?*:ËJq::
:?*:iJq::
:?*:lJq::
:?*:nJq::
:?*:oJq::
:?*:rJq::
:?*:sJq::
:?*:uJq::
:?*:yJq::
HOT_PrintHotstring("que", 1)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en JQT (giquement) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aJqt::
:?*:eJqt::
:?*:ÈJqt::
:?*:ËJqt::
:?*:iJqt::
:?*:lJqt::
:?*:nJqt::
:?*:oJqt::
:?*:rJqt::
:?*:sJqt::
:?*:uJqt::
:?*:yJqt::
HOT_PrintHotstring("ment")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en JR (gieur) :
;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aJr::
:?*:eJr::
:?*:ÈJr::
:?*:ËJr::
:?*:iJr::
:?*:lJr::
:?*:nJr::
:?*:oJr::
:?*:rJr::
:?*:sJr::
:?*:uJr::
:?*:yJr::
HOT_PrintHotstring("ur")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en JS (giesse) :
;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aJs::
:?*:eJs::
:?*:ÈJs::
:?*:ËJs::
:?*:iJs::
:?*:lJs::
:?*:nJs::
:?*:oJs::
:?*:rJs::
:?*:sJs::
:?*:uJs::
:?*:yJs::
HOT_PrintHotstring("sse")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en JT (giement) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aJt::
:?*:eJt::
:?*:ÈJt::
:?*:ËJt::
:?*:iJt::
:?*:lJt::
:?*:nJt::
:?*:oJt::
:?*:rJt::
:?*:sJt::
:?*:uJt::
:?*:yJt::
HOT_PrintHotstring("ment")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en L (elle) :
;;;;;;;;;;;;;;;;;;;;;;;
:?*:eL::
HOT_PrintHotstring("lle")
Return
:?*:qL::
HOT_PrintHotstring("uelle")
Return
:?*:oL::
HOT_PrintHotstring("Îlle")
Return
:?*:aL::
:?*:bL::
:?*:cL::
:?*:dL::
:?*:ÈL::
:?*:fL::
:?*:gL::
:?*:hL::
:?*:iL::
:?*:jL::
:?*:kL::
:?*:lL::
:?*:mL::
:?*:nL::
:?*:pL::
:?*:rL::
:?*:sL::
:?*:tL::
:?*:uL::
:?*:vL::
:?*:wL::
:?*:xL::
:?*:yL::
:?*:zL::
HOT_PrintHotstring("elle")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en LA (ellant) :
;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:eLa::
:?*:qLa::
:?*:oLa::
:?*:aLa::
:?*:bLa::
:?*:cLa::
:?*:dLa::
:?*:ÈLa::
:?*:fLa::
:?*:gLa::
:?*:hLa::
:?*:iLa::
:?*:jLa::
:?*:kLa::
:?*:lLa::
:?*:mLa::
:?*:nLa::
:?*:pLa::
:?*:rLa::
:?*:sLa::
:?*:tLa::
:?*:uLa::
:?*:vLa::
:?*:wLa::
:?*:xLa::
:?*:yLa::
:?*:zLa::
HoT_PrintHotstring("ant", 1)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en LB (ellable) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:eLb::
:?*:qLb::
:?*:oLb::
:?*:aLb::
:?*:bLb::
:?*:cLb::
:?*:dLb::
:?*:ÈLb::
:?*:fLb::
:?*:gLb::
:?*:hLb::
:?*:iLb::
:?*:jLb::
:?*:kLb::
:?*:lLb::
:?*:mLb::
:?*:nLb::
:?*:pLb::
:?*:rLb::
:?*:sLb::
:?*:tLb::
:?*:uLb::
:?*:vLb::
:?*:wLb::
:?*:xLb::
:?*:yLb::
:?*:zLb::
HOT_PrintHotstring("able", 1)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en LBT (ellablement) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:eLbt::
:?*:qLbt::
:?*:oLbt::
:?*:aLbt::
:?*:bLbt::
:?*:cLbt::
:?*:dLbt::
:?*:ÈLbt::
:?*:fLbt::
:?*:gLbt::
:?*:hLbt::
:?*:iLbt::
:?*:jLbt::
:?*:kLbt::
:?*:lLbt::
:?*:mLbt::
:?*:nLbt::
:?*:pLbt::
:?*:rLbt::
:?*:sLbt::
:?*:tLbt::
:?*:uLbt::
:?*:vLbt::
:?*:wLbt::
:?*:xLbt::
:?*:yLbt::
:?*:zLbt::
HOT_PrintHotstring("ment")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en LE (ellence) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:eLe::
:?*:qLe::
:?*:oLe::
:?*:aLe::
:?*:bLe::
:?*:cLe::
:?*:dLe::
:?*:ÈLe::
:?*:fLe::
:?*:gLe::
:?*:hLe::
:?*:iLe::
:?*:jLe::
:?*:kLe::
:?*:lLe::
:?*:mLe::
:?*:nLe::
:?*:pLe::
:?*:rLe::
:?*:sLe::
:?*:tLe::
:?*:uLe::
:?*:vLe::
:?*:wLe::
:?*:xLe::
:?*:yLe::
:?*:zLE::
HOT_PrintHotstring("nce")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en LET (ellencement) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:eLet::
:?*:qLet::
:?*:oLet::
:?*:aLet::
:?*:bLet::
:?*:cLet::
:?*:dLet::
:?*:ÈLet::
:?*:fLet::
:?*:gLet::
:?*:hLet::
:?*:iLet::
:?*:jLet::
:?*:kLet::
:?*:lLet::
:?*:mLet::
:?*:nLet::
:?*:pLet::
:?*:rLet::
:?*:sLet::
:?*:tLet::
:?*:uLet::
:?*:vLet::
:?*:wLet::
:?*:xLet::
:?*:yLet::
:?*:zLet::
HOT_PrintHotstring("ment")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en LT (ellement) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:eLt::
:?*:qLt::
:?*:oLt::
:?*:aLt::
:?*:bLt::
:?*:cLt::
:?*:dLt::
:?*:ÈLt::
:?*:fLt::
:?*:gLt::
:?*:hLt::
:?*:iLt::
:?*:jLt::
:?*:kLt::
:?*:lLt::
:?*:mLt::
:?*:nLt::
:?*:pLt::
:?*:rLt::
:?*:sLt::
:?*:tLt::
:?*:uLt::
:?*:vLt::
:?*:wLt::
:?*:xLt::
:?*:yLt::
:?*:zLt::
HOT_PrintHotstring("ment")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en LZ (elleuse) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:elz::
:?*:qlz::
:?*:olz::
:?*:alz::
:?*:blz::
:?*:clz::
:?*:dlz::
:?*:Èlz::
:?*:flz::
:?*:glz::
:?*:hlz::
:?*:ilz::
:?*:jlz::
:?*:klz::
:?*:llz::
:?*:mlz::
:?*:nlz::
:?*:plz::
:?*:rlz::
:?*:slz::
:?*:tlz::
:?*:ulz::
:?*:vlz::
:?*:wlz::
:?*:xlz::
:?*:ylz::
:?*:zlz::
HOT_PrintHotstring("use")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en LZT (elleusement) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:eLzt::
:?*:qLzt::
:?*:oLzt::
:?*:aLzt::
:?*:bLzt::
:?*:cLzt::
:?*:dLzt::
:?*:ÈLzt::
:?*:fLzt::
:?*:gLzt::
:?*:hLzt::
:?*:iLzt::
:?*:jLzt::
:?*:kLzt::
:?*:lLzt::
:?*:mLzt::
:?*:nLzt::
:?*:pLzt::
:?*:rLzt::
:?*:sLzt::
:?*:tLzt::
:?*:uLzt::
:?*:vLzt::
:?*:wLzt::
:?*:xLzt::
:?*:yLzt::
:?*:zLzt::
HOT_PrintHotstring("ment")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en M (isme) :
;;;;;;;;;;;;;;;;;;;;;;;
:?*:qM::
HOT_PrintHotstring("uisme")
Return
:?*:iM::
:?*:ÓM::
:?*:yM::
HOT_PrintHotstring("sme")
Return
:?*:aM::
:?*:bM::
:?*:cM::
:?*:dM::
:?*:eM::
:?*:ÈM::
:?*:ËM::
:?*:fM::
:?*:gM::
:?*:hM::
:?*:jM::
:?*:kM::
:?*:lM::
:?*:mM::
:?*:nM::
:?*:oM::
:?*:ÙM::
:?*:pM::
:?*:rM::
:?*:sM::
:?*:tM::
:?*:uM::
:?*:vM::
:?*:wM::
:?*:xM::
:?*:zM::
HOT_PrintHotstring("isme")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en MA (ismant) :
;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:qMa::
:?*:iMa::
:?*:ÓMa::
:?*:yMa::
:?*:aMa::
:?*:bMa::
:?*:cMa::
:?*:dMa::
:?*:eMa::
:?*:ÈMa::
:?*:ËMa::
:?*:fMa::
:?*:gMa::
:?*:hMa::
:?*:jMa::
:?*:kMa::
:?*:lMa::
:?*:mMa::
:?*:nMa::
:?*:oMa::
:?*:ÙMa::
:?*:pMa::
:?*:rMa::
:?*:sMa::
:?*:tMa::
:?*:uMa::
:?*:vMa::
:?*:wMa::
:?*:xMa::
:?*:zMa::
HoT_PrintHotstring("ant", 1)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en MB (ismable) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:qMb::
:?*:iMb::
:?*:ÓMb::
:?*:yMb::
:?*:aMb::
:?*:bMb::
:?*:cMb::
:?*:dMb::
:?*:eMb::
:?*:ÈMb::
:?*:ËMb::
:?*:fMb::
:?*:gMb::
:?*:hMb::
:?*:jMb::
:?*:kMb::
:?*:lMb::
:?*:mMb::
:?*:nMb::
:?*:oMb::
:?*:ÙMb::
:?*:pMb::
:?*:rMb::
:?*:sMb::
:?*:tMb::
:?*:uMb::
:?*:vMb::
:?*:wMb::
:?*:xMb::
:?*:zMb::
HOT_PrintHotstring("able", 1)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en ML (ismelle) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:qMl::
:?*:iMl::
:?*:ÓMl::
:?*:yMl::
:?*:aMl::
:?*:bMl::
:?*:cMl::
:?*:dMl::
:?*:eMl::
:?*:ÈMl::
:?*:ËMl::
:?*:fMl::
:?*:gMl::
:?*:hMl::
:?*:jMl::
:?*:kMl::
:?*:lMl::
:?*:mMl::
:?*:nMl::
:?*:oMl::
:?*:ÙMl::
:?*:pMl::
:?*:rMl::
:?*:sMl::
:?*:tMl::
:?*:uMl::
:?*:vMl::
:?*:wMl::
:?*:xMl::
:?*:zMl::
HOT_PrintHotstring("lle")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en MQ (ismique) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:qMq::
:?*:iMq::
:?*:ÓMq::
:?*:yMq::
:?*:aMq::
:?*:bMq::
:?*:cMq::
:?*:dMq::
:?*:eMq::
:?*:ÈMq::
:?*:ËMq::
:?*:fMq::
:?*:gMq::
:?*:hMq::
:?*:jMq::
:?*:kMq::
:?*:lMq::
:?*:mMq::
:?*:nMq::
:?*:oMq::
:?*:ÙMq::
:?*:pMq::
:?*:rMq::
:?*:sMq::
:?*:tMq::
:?*:uMq::
:?*:vMq::
:?*:wMq::
:?*:xMq::
:?*:zMq::
HOT_PrintHotstring("ique", 1)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en MQT (ismiquement) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:qMqt::
:?*:iMqt::
:?*:ÓMqt::
:?*:yMqt::
:?*:aMqt::
:?*:bMqt::
:?*:cMqt::
:?*:dMqt::
:?*:eMqt::
:?*:ÈMqt::
:?*:ËMqt::
:?*:fMqt::
:?*:gMqt::
:?*:hMqt::
:?*:jMqt::
:?*:kMqt::
:?*:lMqt::
:?*:mMqt::
:?*:nMqt::
:?*:oMqt::
:?*:ÙMqt::
:?*:pMqt::
:?*:rMqt::
:?*:sMqt::
:?*:tMqt::
:?*:uMqt::
:?*:vMqt::
:?*:wMqt::
:?*:xMqt::
:?*:zMqt::
HOT_PrintHotstring("ment")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en N (aison) :
;;;;;;;;;;;;;;;;;;;;;;;;
:?*:qN::
HOT_PrintHotstring("uaison")
Return
:?*:aN::
HOT_PrintHotstring("ison")
Return
:?*:bN::
:?*:cN::
:?*:dN::
:?*:eN::
:?*:ÈN::
:?*:ËN::
:?*:fN::
:?*:gN::
:?*:hN::
:?*:iN::
:?*:jN::
:?*:kN::
:?*:lN::
:?*:mN::
:?*:nN::
:?*:oN::
:?*:pN::
:?*:rN::
:?*:sN::
:?*:tN::
:?*:uN::
:?*:vN::
:?*:wN::
:?*:xN::
:?*:yN::
:?*:zN::
HOT_PrintHotstring("aison")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en NA (aisonnant) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:qNa::
:?*:aNa::
:?*:bNa::
:?*:cNa::
:?*:dNa::
:?*:eNa::
:?*:ÈNa::
:?*:ËNa::
:?*:fNa::
:?*:gNa::
:?*:hNa::
:?*:iNa::
:?*:jNa::
:?*:kNa::
:?*:lNa::
:?*:mNa::
:?*:nNa::
:?*:oNa::
:?*:pNa::
:?*:rNa::
:?*:sNa::
:?*:tNa::
:?*:uNa::
:?*:vNa::
:?*:wNa::
:?*:xNa::
:?*:yNa::
:?*:zNa::
HOT_PrintHotstring("nant")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en NB (aisonnable) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:qNb::
:?*:aNb::
:?*:bNb::
:?*:cNb::
:?*:dNb::
:?*:eNb::
:?*:ÈNb::
:?*:ËNb::
:?*:fNb::
:?*:gNb::
:?*:hNb::
:?*:iNb::
:?*:jNb::
:?*:kNb::
:?*:lNb::
:?*:mNb::
:?*:nNb::
:?*:oNb::
:?*:pNb::
:?*:rNb::
:?*:sNb::
:?*:tNb::
:?*:uNb::
:?*:vNb::
:?*:wNb::
:?*:xNb::
:?*:yNb::
:?*:zNb::
HOT_PrintHotstring("nable")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en NBT (aisonnablement) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:qNbt::
:?*:aNbt::
:?*:bNbt::
:?*:cNbt::
:?*:dNbt::
:?*:eNbt::
:?*:ÈNbt::
:?*:ËNbt::
:?*:fNbt::
:?*:gNbt::
:?*:hNbt::
:?*:iNbt::
:?*:jNbt::
:?*:kNbt::
:?*:lNbt::
:?*:mNbt::
:?*:nNbt::
:?*:oNbt::
:?*:pNbt::
:?*:rNbt::
:?*:sNbt::
:?*:tNbt::
:?*:uNbt::
:?*:vNbt::
:?*:wNbt::
:?*:xNbt::
:?*:yNbt::
:?*:zNbt::
HOT_PrintHotstring("ment")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en NR (aisonneur) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:qNr::
:?*:aNr::
:?*:bNr::
:?*:cNr::
:?*:dNr::
:?*:eNr::
:?*:ÈNr::
:?*:ËNr::
:?*:fNr::
:?*:gNr::
:?*:hNr::
:?*:iNr::
:?*:jNr::
:?*:kNr::
:?*:lNr::
:?*:mNr::
:?*:nNr::
:?*:oNr::
:?*:pNr::
:?*:rNr::
:?*:sNr::
:?*:tNr::
:?*:uNr::
:?*:vNr::
:?*:wNr::
:?*:xNr::
:?*:yNr::
:?*:zNr::
HOT_PrintHotstring("neur")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en NT (aisonnement) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:qNt::
:?*:aNt::
:?*:bNt::
:?*:cNt::
:?*:dNt::
:?*:eNt::
:?*:ÈNt::
:?*:ËNt::
:?*:fNt::
:?*:gNt::
:?*:hNt::
:?*:iNt::
:?*:jNt::
:?*:kNt::
:?*:lNt::
:?*:mNt::
:?*:nNt::
:?*:oNt::
:?*:pNt::
:?*:rNt::
:?*:sNt::
:?*:tNt::
:?*:uNt::
:?*:vNt::
:?*:wNt::
:?*:xNt::
:?*:yNt::
:?*:zNt::
HOT_PrintHotstring("nement")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en NZ (aisonneuse) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:qNz::
:?*:aNz::
:?*:bNz::
:?*:cNz::
:?*:dNz::
:?*:eNz::
:?*:ÈNz::
:?*:ËNz::
:?*:fNz::
:?*:gNz::
:?*:hNz::
:?*:iNz::
:?*:jNz::
:?*:kNz::
:?*:lNz::
:?*:mNz::
:?*:nNz::
:?*:oNz::
:?*:pNz::
:?*:rNz::
:?*:sNz::
:?*:tNz::
:?*:uNz::
:?*:vNz::
:?*:wNz::
:?*:xNz::
:?*:yNz::
:?*:zNz::
HOT_PrintHotstring("neuse")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en O (tion) :
;;;;;;;;;;;;;;;;;;;;;;;
:?*:tO::
HOT_PrintHotstring("ion")
Return
:?*:aO::
:?*:bO::
:?*:cO::
:?*:eO::
:?*:ÈO::
:?*:ËO::
:?*:gO::
:?*:iO::
:?*:kO::
:?*:lO::
:?*:nO::
:?*:oO::
:?*:ÙO::
:?*:pO::
:?*:rO::
:?*:sO::
:?*:uO::
:?*:yO::
HOT_PrintHotstring("tion")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en OA (tionnant) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:tOa::
:?*:aOa::
:?*:bOa::
:?*:cOa::
:?*:eOa::
:?*:ÈOa::
:?*:ËOa::
:?*:gOa::
:?*:iOa::
:?*:kOa::
:?*:lOa::
:?*:nOa::
:?*:oOa::
:?*:ÙOa::
:?*:pOa::
:?*:rOa::
:?*:sOa::
:?*:uOa::
:?*:yOa::
HOT_PrintHotstring("nant")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en OB (tionnable) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:tOb::
:?*:aOb::
:?*:bOb::
:?*:cOb::
:?*:eOb::
:?*:ÈOb::
:?*:ËOb::
:?*:gOb::
:?*:iOb::
:?*:kOb::
:?*:lOb::
:?*:nOb::
:?*:oOb::
:?*:ÙOb::
:?*:pOb::
:?*:rOb::
:?*:sOb::
:?*:uOb::
:?*:yOb::
HOT_PrintHotstring("nable")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en OBT (tionnablement) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:tObt::
:?*:aObt::
:?*:bObt::
:?*:cObt::
:?*:eObt::
:?*:ÈObt::
:?*:ËObt::
:?*:gObt::
:?*:iObt::
:?*:kObt::
:?*:lObt::
:?*:nObt::
:?*:oObt::
:?*:ÙObt::
:?*:pObt::
:?*:rObt::
:?*:sObt::
:?*:uObt::
:?*:yObt::
HOT_PrintHotstring("ment")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en OL (tionnelle) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:tOl::
:?*:aOl::
:?*:bOl::
:?*:cOl::
:?*:eOl::
:?*:ÈOl::
:?*:ËOl::
:?*:gOl::
:?*:iOl::
:?*:kOl::
:?*:lOl::
:?*:nOl::
:?*:oOl::
:?*:ÙOl::
:?*:pOl::
:?*:rOl::
:?*:sOl::
:?*:uOl::
:?*:yOl::
HOT_PrintHotstring("nelle")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en OLT (tionnellement) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:tOlt::
:?*:aOlt::
:?*:bOlt::
:?*:cOlt::
:?*:eOlt::
:?*:ÈOlt::
:?*:ËOlt::
:?*:gOlt::
:?*:iOlt::
:?*:kOlt::
:?*:lOlt::
:?*:nOlt::
:?*:oOlt::
:?*:ÙOlt::
:?*:pOlt::
:?*:rOlt::
:?*:sOlt::
:?*:uOlt::
:?*:yOlt::
HOT_PrintHotstring("ment")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en OM (tionisme) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:tOm::
:?*:aOm::
:?*:bOm::
:?*:cOm::
:?*:eOm::
:?*:ÈOm::
:?*:ËOm::
:?*:gOm::
:?*:iOm::
:?*:kOm::
:?*:lOm::
:?*:nOm::
:?*:oOm::
:?*:ÙOm::
:?*:pOm::
:?*:rOm::
:?*:sOm::
:?*:uOm::
:?*:yOm::
HOT_PrintHotstring("isme")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en OQ (tionique) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:tOq::
:?*:aOq::
:?*:bOq::
:?*:cOq::
:?*:eOq::
:?*:ÈOq::
:?*:ËOq::
:?*:gOq::
:?*:iOq::
:?*:kOq::
:?*:lOq::
:?*:nOq::
:?*:oOq::
:?*:ÙOq::
:?*:pOq::
:?*:rOq::
:?*:sOq::
:?*:uOq::
:?*:yOq::
HOT_PrintHotstring("ique")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en OQT (tioniquement) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:tOqt::
:?*:aOqt::
:?*:bOqt::
:?*:cOqt::
:?*:eOqt::
:?*:ÈOqt::
:?*:ËOqt::
:?*:gOqt::
:?*:iOqt::
:?*:kOqt::
:?*:lOqt::
:?*:nOqt::
:?*:oOqt::
:?*:ÙOqt::
:?*:pOqt::
:?*:rOqt::
:?*:sOqt::
:?*:uOqt::
:?*:yOqt::
HOT_PrintHotstring("ment")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en OT (tionnement) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:tOt::
:?*:aOt::
:?*:bOt::
:?*:cOt::
:?*:eOt::
:?*:ÈOt::
:?*:ËOt::
:?*:gOt::
:?*:iOt::
:?*:kOt::
:?*:lOt::
:?*:nOt::
:?*:oOt::
:?*:ÙOt::
:?*:pOt::
:?*:rOt::
:?*:sOt::
:?*:uOt::
:?*:yOt::
HOT_PrintHotstring("nement")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en Q (ique) :
;;;;;;;;;;;;;;;;;;;;;;;
:?*:aQ::
:?*:eQ::
:?*:ÈQ::
:?*:ËQ::
:?*:iQ::
:?*:oQ::
:?*:yQ::
HOT_PrintHotstring("que")
Return
:?*:bQ::
:?*:cQ::
:?*:dQ::
:?*:fQ::
:?*:gQ::
:?*:hQ::
:?*:jQ::
:?*:lQ::
:?*:mQ::
:?*:nQ::
:?*:pQ::
:?*:rQ::
:?*:sQ::
:?*:tQ::
:?*:uQ::
:?*:vQ::
:?*:xQ::
:?*:zQ::
HOT_PrintHotstring("ique")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en QA (iquant) :
;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aQa::
:?*:eQa::
:?*:ÈQa::
:?*:ËQa::
:?*:iQa::
:?*:oQa::
:?*:yQa::
:?*:bQa::
:?*:cQa::
:?*:dQa::
:?*:fQa::
:?*:gQa::
:?*:hQa::
:?*:jQa::
:?*:lQa::
:?*:mQa::
:?*:nQa::
:?*:pQa::
:?*:rQa::
:?*:sQa::
:?*:tQa::
:?*:uQa::
:?*:vQa::
:?*:xQa::
:?*:zQa::
HoT_PrintHotstring("ant", 1)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en QB (iquable) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aQb::
:?*:eQb::
:?*:ÈQb::
:?*:ËQb::
:?*:iQb::
:?*:oQb::
:?*:yQb::
:?*:bQb::
:?*:cQb::
:?*:dQb::
:?*:fQb::
:?*:gQb::
:?*:hQb::
:?*:jQb::
:?*:lQb::
:?*:mQb::
:?*:nQb::
:?*:pQb::
:?*:rQb::
:?*:sQb::
:?*:tQb::
:?*:uQb::
:?*:vQb::
:?*:xQb::
:?*:zQb::
HOT_PrintHotstring("able", 1)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en QBT (iquablement) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aQbt::
:?*:eQbt::
:?*:ÈQbt::
:?*:ËQbt::
:?*:iQbt::
:?*:oQbt::
:?*:yQbt::
:?*:bQbt::
:?*:cQbt::
:?*:dQbt::
:?*:fQbt::
:?*:gQbt::
:?*:hQbt::
:?*:jQbt::
:?*:lQbt::
:?*:mQbt::
:?*:nQbt::
:?*:pQbt::
:?*:rQbt::
:?*:sQbt::
:?*:tQbt::
:?*:uQbt::
:?*:vQbt::
:?*:xQbt::
:?*:zQbt::
HOT_PrintHotstring("ment")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en QR (iqueur) :
;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aQr::
:?*:eQr::
:?*:ÈQr::
:?*:ËQr::
:?*:iQr::
:?*:oQr::
:?*:yQr::
:?*:bQr::
:?*:cQr::
:?*:dQr::
:?*:fQr::
:?*:gQr::
:?*:hQr::
:?*:jQr::
:?*:lQr::
:?*:mQr::
:?*:nQr::
:?*:pQr::
:?*:rQr::
:?*:sQr::
:?*:tQr::
:?*:uQr::
:?*:vQr::
:?*:xQr::
:?*:zQr::
HOT_PrintHotstring("ur")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en QT (iquement) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aQt::
:?*:eQt::
:?*:ÈQt::
:?*:ËQt::
:?*:iQt::
:?*:oQt::
:?*:yQt::
:?*:bQt::
:?*:cQt::
:?*:dQt::
:?*:fQt::
:?*:gQt::
:?*:hQt::
:?*:jQt::
:?*:lQt::
:?*:mQt::
:?*:nQt::
:?*:pQt::
:?*:rQt::
:?*:sQt::
:?*:tQt::
:?*:uQt::
:?*:vQt::
:?*:xQt::
:?*:zQt::
HOT_PrintHotstring("ment")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en QZ (iqueuse) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:aQz::
:?*:eQz::
:?*:ÈQz::
:?*:ËQz::
:?*:iQz::
:?*:oQz::
:?*:yQz::
:?*:bQz::
:?*:cQz::
:?*:dQz::
:?*:fQz::
:?*:gQz::
:?*:hQz::
:?*:jQz::
:?*:lQz::
:?*:mQz::
:?*:nQz::
:?*:pQz::
:?*:rQz::
:?*:sQz::
:?*:tQz::
:?*:uQz::
:?*:vQz::
:?*:xQz::
:?*:zQz::
HOT_PrintHotstring("use")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en R (eur) :
;;;;;;;;;;;;;;;;;;;;;;
:?*:eR::
HOT_PrintHotstring("ur")
Return
:?*:qR::
HOT_PrintHotstring("ueur")
Return
:?*:aR::
:?*:bR::
:?*:cR::
:?*:dR::
:?*:ÈR::
:?*:ËR::
:?*:fR::
:?*:gR::
:?*:hR::
:?*:iR::
:?*:kR::
:?*:lR::
:?*:mR::
:?*:nR::
:?*:oR::
:?*:pR::
:?*:rR::
:?*:sR::
:?*:tR::
:?*:uR::
:?*:vR::
:?*:wR::
:?*:xR::
:?*:yR::
:?*:zR::
HOT_PrintHotstring("eur")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en RA (eurant) :
;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:eRa::
:?*:qRa::
:?*:aRa::
:?*:bRa::
:?*:cRa::
:?*:dRa::
:?*:ÈRa::
:?*:ËRa::
:?*:fRa::
:?*:gRa::
:?*:hRa::
:?*:iRa::
:?*:jRa::
:?*:kRa::
:?*:lRa::
:?*:mRa::
:?*:nRa::
:?*:oRa::
:?*:pRa::
:?*:rRa::
:?*:sRa::
:?*:tRa::
:?*:uRa::
:?*:vRa::
:?*:wRa::
:?*:xRa::
:?*:yRa::
:?*:zRa::
HOT_PrintHotstring("ant")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en RB (eurable) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:eRb::
:?*:qRb::
:?*:aRb::
:?*:bRb::
:?*:cRb::
:?*:dRb::
:?*:ÈRb::
:?*:ËRb::
:?*:fRb::
:?*:gRb::
:?*:hRb::
:?*:iRb::
:?*:jRb::
:?*:kRb::
:?*:lRb::
:?*:mRb::
:?*:nRb::
:?*:oRb::
:?*:pRb::
:?*:rRb::
:?*:sRb::
:?*:tRb::
:?*:uRb::
:?*:vRb::
:?*:wRb::
:?*:xRb::
:?*:yRb::
:?*:zRb::
HOT_PrintHotstring("able")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en RBT (eurablement) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:eRbt::
:?*:qRbt::
:?*:aRbt::
:?*:bRbt::
:?*:cRbt::
:?*:dRbt::
:?*:ÈRbt::
:?*:ËRbt::
:?*:fRbt::
:?*:gRbt::
:?*:hRbt::
:?*:iRbt::
:?*:jRbt::
:?*:kRbt::
:?*:lRbt::
:?*:mRbt::
:?*:nRbt::
:?*:oRbt::
:?*:pRbt::
:?*:rRbt::
:?*:sRbt::
:?*:tRbt::
:?*:uRbt::
:?*:vRbt::
:?*:wRbt::
:?*:xRbt::
:?*:yRbt::
:?*:zRbt::
HOT_PrintHotstring("ment")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en RN (euraison) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:eRn::
:?*:qRn::
:?*:aRn::
:?*:bRn::
:?*:cRn::
:?*:dRn::
:?*:ÈRn::
:?*:ËRn::
:?*:fRn::
:?*:gRn::
:?*:hRn::
:?*:iRn::
:?*:jRn::
:?*:kRn::
:?*:lRn::
:?*:mRn::
:?*:nRn::
:?*:oRn::
:?*:pRn::
:?*:rRn::
:?*:sRn::
:?*:tRn::
:?*:uRn::
:?*:vRn::
:?*:wRn::
:?*:xRn::
:?*:yRn::
:?*:zRn::
HOT_PrintHotstring("aison")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en RQ (eurique) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:eRq::
:?*:qRq::
:?*:aRq::
:?*:bRq::
:?*:cRq::
:?*:dRq::
:?*:ÈRq::
:?*:ËRq::
:?*:fRq::
:?*:gRq::
:?*:hRq::
:?*:iRq::
:?*:jRq::
:?*:kRq::
:?*:lRq::
:?*:mRq::
:?*:nRq::
:?*:oRq::
:?*:pRq::
:?*:rRq::
:?*:sRq::
:?*:tRq::
:?*:uRq::
:?*:vRq::
:?*:wRq::
:?*:xRq::
:?*:yRq::
:?*:zRq::
HOT_PrintHotstring("ique")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en RQT (euriquement) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:eRqt::
:?*:qRqt::
:?*:aRqt::
:?*:bRqt::
:?*:cRqt::
:?*:dRqt::
:?*:ÈRqt::
:?*:ËRqt::
:?*:fRqt::
:?*:gRqt::
:?*:hRqt::
:?*:iRqt::
:?*:jRqt::
:?*:kRqt::
:?*:lRqt::
:?*:mRqt::
:?*:nRqt::
:?*:oRqt::
:?*:pRqt::
:?*:rRqt::
:?*:sRqt::
:?*:tRqt::
:?*:uRqt::
:?*:vRqt::
:?*:wRqt::
:?*:xRqt::
:?*:yRqt::
:?*:zRqt::
HOT_PrintHotstring("ment")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en RT (eurement) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:eRt::
:?*:qRt::
:?*:aRt::
:?*:bRt::
:?*:cRt::
:?*:dRt::
:?*:ÈRt::
:?*:ËRt::
:?*:fRt::
:?*:gRt::
:?*:hRt::
:?*:iRt::
:?*:jRt::
:?*:kRt::
:?*:lRt::
:?*:mRt::
:?*:nRt::
:?*:oRt::
:?*:pRt::
:?*:rRt::
:?*:sRt::
:?*:tRt::
:?*:uRt::
:?*:vRt::
:?*:wRt::
:?*:xRt::
:?*:yRt::
:?*:zRt::
HOT_PrintHotstring("ement")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en RZ (eureuse) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:eRz::
:?*:qRz::
:?*:aRz::
:?*:bRz::
:?*:cRz::
:?*:dRz::
:?*:ÈRz::
:?*:ËRz::
:?*:fRz::
:?*:gRz::
:?*:hRz::
:?*:iRz::
:?*:jRz::
:?*:kRz::
:?*:lRz::
:?*:mRz::
:?*:nRz::
:?*:oRz::
:?*:pRz::
:?*:rRz::
:?*:sRz::
:?*:tRz::
:?*:uRz::
:?*:vRz::
:?*:wRz::
:?*:xRz::
:?*:yRz::
:?*:zRz::
HOT_PrintHotstring("euse")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en RZT (eureusement) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:eRzt::
:?*:qRzt::
:?*:aRzt::
:?*:bRzt::
:?*:cRzt::
:?*:dRzt::
:?*:ÈRzt::
:?*:ËRzt::
:?*:fRzt::
:?*:gRzt::
:?*:hRzt::
:?*:iRzt::
:?*:jRzt::
:?*:kRzt::
:?*:lRzt::
:?*:mRzt::
:?*:nRzt::
:?*:oRzt::
:?*:pRzt::
:?*:rRzt::
:?*:sRzt::
:?*:tRzt::
:?*:uRzt::
:?*:vRzt::
:?*:wRzt::
:?*:xRzt::
:?*:yRzt::
:?*:zRzt::
HOT_PrintHotstring("ment")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en S (esse) :
;;;;;;;;;;;;;;;;;;;;;;;
:?*:eS::
HOT_PrintHotstring("sse")
Return
:?*:qS::
HOT_PrintHotstring("uesse")
Return
:?*:aS::
:?*:bS::
:?*:cS::
:?*:dS::
:?*:ÈS::
:?*:fS::
:?*:gS::
:?*:hS::
:?*:iS::
:?*:jS::
:?*:kS::
:?*:lS::
:?*:mS::
:?*:nS::
:?*:oS::
:?*:pS::
:?*:rS::
:?*:sS::
:?*:tS::
:?*:uS::
:?*:vS::
:?*:wS::
:?*:xS::
:?*:yS::
:?*:zS::
HOT_PrintHotstring("esse")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en SA (essant) :
;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:eSa::
:?*:qSa::
:?*:aSa::
:?*:bSa::
:?*:cSa::
:?*:dSa::
:?*:ÈSa::
:?*:fSa::
:?*:gSa::
:?*:hSa::
:?*:iSa::
:?*:jSa::
:?*:kSa::
:?*:lSa::
:?*:mSa::
:?*:nSa::
:?*:oSa::
:?*:pSa::
:?*:rSa::
:?*:sSa::
:?*:tSa::
:?*:uSa::
:?*:vSa::
:?*:wSa::
:?*:xSa::
:?*:ySa::
:?*:zSa::
HoT_PrintHotstring("ant", 1)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en SB (essable) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:eSb::
:?*:qSb::
:?*:aSb::
:?*:bSb::
:?*:cSb::
:?*:dSb::
:?*:ÈSb::
:?*:fSb::
:?*:gSb::
:?*:hSb::
:?*:iSb::
:?*:jSb::
:?*:kSb::
:?*:lSb::
:?*:mSb::
:?*:nSb::
:?*:oSb::
:?*:pSb::
:?*:rSb::
:?*:sSb::
:?*:tSb::
:?*:uSb::
:?*:vSb::
:?*:wSb::
:?*:xSb::
:?*:ySb::
:?*:zSb::
HOT_PrintHotstring("able", 1)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en SBT (essablement) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:eSbt::
:?*:qSbt::
:?*:aSbt::
:?*:bSbt::
:?*:cSbt::
:?*:dSbt::
:?*:ÈSbt::
:?*:fSbt::
:?*:gSbt::
:?*:hSbt::
:?*:iSbt::
:?*:jSbt::
:?*:kSbt::
:?*:lSbt::
:?*:mSbt::
:?*:nSbt::
:?*:oSbt::
:?*:pSbt::
:?*:rSbt::
:?*:sSbt::
:?*:tSbt::
:?*:uSbt::
:?*:vSbt::
:?*:wSbt::
:?*:xSbt::
:?*:ySbt::
:?*:zSbt::
HOT_PrintHotstring("ment")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en SE (essence) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:Se::
:?*:eSe::
:?*:qSe::
:?*:aSe::
:?*:bSe::
:?*:cSe::
:?*:dSe::
:?*:ÈSe::
:?*:fSe::
:?*:gSe::
:?*:hSe::
:?*:iSe::
:?*:jSe::
:?*:kSe::
:?*:lSe::
:?*:mSe::
:?*:nSe::
:?*:oSe::
:?*:pSe::
:?*:rSe::
:?*:sSe::
:?*:tSe::
:?*:uSe::
:?*:vSe::
:?*:wSe::
:?*:xSe::
:?*:ySe::
:?*:zSe::
HOT_PrintHotstring("nce")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en SQ (essique) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:eSq::
:?*:qSq::
:?*:aSq::
:?*:bSq::
:?*:cSq::
:?*:dSq::
:?*:ÈSq::
:?*:fSq::
:?*:gSq::
:?*:hSq::
:?*:iSq::
:?*:jSq::
:?*:kSq::
:?*:lSq::
:?*:mSq::
:?*:nSq::
:?*:oSq::
:?*:pSq::
:?*:rSq::
:?*:sSq::
:?*:tSq::
:?*:uSq::
:?*:vSq::
:?*:wSq::
:?*:xSq::
:?*:ySq::
:?*:zSq::
HOT_PrintHotstring("ique", 1)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en SQT (essiquement) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:eSqt::
:?*:qSqt::
:?*:aSqt::
:?*:bSqt::
:?*:cSqt::
:?*:dSqt::
:?*:ÈSqt::
:?*:fSqt::
:?*:gSqt::
:?*:hSqt::
:?*:iSqt::
:?*:jSqt::
:?*:kSqt::
:?*:lSqt::
:?*:mSqt::
:?*:nSqt::
:?*:oSqt::
:?*:pSqt::
:?*:rSqt::
:?*:sSqt::
:?*:tSqt::
:?*:uSqt::
:?*:vSqt::
:?*:wSqt::
:?*:xSqt::
:?*:ySqt::
:?*:zSqt::
HOT_PrintHotstring("ment")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en SR (esseur) :
;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:eSr::
:?*:qSr::
:?*:aSr::
:?*:bSr::
:?*:cSr::
:?*:dSr::
:?*:ÈSr::
:?*:fSr::
:?*:gSr::
:?*:hSr::
:?*:iSr::
:?*:jSr::
:?*:kSr::
:?*:lSr::
:?*:mSr::
:?*:nSr::
:?*:oSr::
:?*:pSr::
:?*:rSr::
:?*:sSr::
:?*:tSr::
:?*:uSr::
:?*:vSr::
:?*:wSr::
:?*:xSr::
:?*:ySr::
:?*:zSr::
HOT_PrintHotstring("ur")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en ST (essement) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:eSt::
:?*:qSt::
:?*:aSt::
:?*:bSt::
:?*:cSt::
:?*:dSt::
:?*:ÈSt::
:?*:fSt::
:?*:gSt::
:?*:hSt::
:?*:iSt::
:?*:jSt::
:?*:kSt::
:?*:lSt::
:?*:mSt::
:?*:nSt::
:?*:oSt::
:?*:pSt::
:?*:rSt::
:?*:sSt::
:?*:tSt::
:?*:uSt::
:?*:vSt::
:?*:wSt::
:?*:xSt::
:?*:ySt::
:?*:zSt::
HOT_PrintHotstring("ment")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en SZ (esseuse) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:eSz::
:?*:qSz::
:?*:aSz::
:?*:bSz::
:?*:cSz::
:?*:dSz::
:?*:ÈSz::
:?*:fSz::
:?*:gSz::
:?*:hSz::
:?*:iSz::
:?*:jSz::
:?*:kSz::
:?*:lSz::
:?*:mSz::
:?*:nSz::
:?*:oSz::
:?*:pSz::
:?*:rSz::
:?*:sSz::
:?*:tSz::
:?*:uSz::
:?*:vSz::
:?*:wSz::
:?*:xSz::
:?*:ySz::
:?*:zSz::
HOT_PrintHotstring("use")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en T (ment) :
;;;;;;;;;;;;;;;;;;;;;;;
:?*:mT::
HOT_PrintHotstring("ent")
Return
:?*:uT::
:?*:iT::
:?*:eT::
:?*:ÈT::
:?*:ËT::
:?*:oT::
HOT_PrintHotstring("ment")
Return
:?*:aT::
HOT_PrintHotstring("mment")
Return
:?*:qT::
HOT_PrintHotstring("uement")
Return
:?*:bT::
:?*:cT::
:?*:dT::
:?*:fT::
:?*:gT::
:?*:hT::
:?*:lT::
:?*:mT::
:?*:nT::
:?*:pT::
:?*:rT::
:?*:sT::
:?*:tT::
:?*:vT::
:?*:wT::
:?*:xT::
:?*:yT::
:?*:zT::
HOT_PrintHotstring("ement")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en TB (mentable) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:Tb::
:?*:mTb::
:?*:uTb::
:?*:iTb::
:?*:eTb::
:?*:ÈTb::
:?*:ËTb::
:?*:aTb::
:?*:qTb::
:?*:bTb::
:?*:cTb::
:?*:dTb::
:?*:fTb::
:?*:gTb::
:?*:hTb::
:?*:lTb::
:?*:mTb::
:?*:nTb::
:?*:oTb::
:?*:pTb::
:?*:rTb::
:?*:sTb::
:?*:tTb::
:?*:vTb::
:?*:wTb::
:?*:xTb::
:?*:yTb::
:?*:zTb::
HOT_PrintHotstring("able")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en TBT (mentablement) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:mTbt::
:?*:uTbt::
:?*:iTbt::
:?*:eTbt::
:?*:ÈTbt::
:?*:ËTbt::
:?*:aTbt::
:?*:qTbt::
:?*:bTbt::
:?*:cTbt::
:?*:dTbt::
:?*:fTbt::
:?*:gTbt::
:?*:hTbt::
:?*:lTbt::
:?*:mTbt::
:?*:nTbt::
:?*:oTbt::
:?*:pTbt::
:?*:rTbt::
:?*:sTbt::
:?*:tTbt::
:?*:vTbt::
:?*:wTbt::
:?*:xTbt::
:?*:yTbt::
:?*:zTbt::
HOT_PrintHotstring("ment")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en TE (mentence) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:mTe::
:?*:uTe::
:?*:iTe::
:?*:eTe::
:?*:ÈTe::
:?*:ËTe::
:?*:aTe::
:?*:qTe::
:?*:bTe::
:?*:cTe::
:?*:dTe::
:?*:fTe::
:?*:gTe::
:?*:hTe::
:?*:lTe::
:?*:mTe::
:?*:nTe::
:?*:oTe::
:?*:pTe::
:?*:rTe::
:?*:sTe::
:?*:tTe::
:?*:vTe::
:?*:wTe::
:?*:xTe::
:?*:yTe::
:?*:zTe::
HOT_PrintHotstring("ence")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en TL (mentelle) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:mTl::
:?*:uTl::
:?*:iTl::
:?*:eTl::
:?*:ÈTl::
:?*:ËTl::
:?*:aTl::
:?*:qTl::
:?*:bTl::
:?*:cTl::
:?*:dTl::
:?*:fTl::
:?*:gTl::
:?*:hTl::
:?*:lTl::
:?*:mTl::
:?*:nTl::
:?*:oTl::
:?*:pTl::
:?*:rTl::
:?*:sTl::
:?*:tTl::
:?*:vTl::
:?*:wTl::
:?*:xTl::
:?*:yTl::
:?*:zTl::
HOT_PrintHotstring("elle")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en TM (mentisme) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:mTm::
:?*:uTm::
:?*:iTm::
:?*:eTm::
:?*:ÈTm::
:?*:ËTm::
:?*:aTm::
:?*:qTm::
:?*:bTm::
:?*:cTm::
:?*:dTm::
:?*:fTm::
:?*:gTm::
:?*:hTm::
:?*:lTm::
:?*:mTm::
:?*:nTm::
:?*:oTm::
:?*:pTm::
:?*:rTm::
:?*:sTm::
:?*:tTm::
:?*:vTm::
:?*:wTm::
:?*:xTm::
:?*:yTm::
:?*:zTm::
HOT_PrintHotstring("isme")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en TN (mentaison) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:mTn::
:?*:uTn::
:?*:iTn::
:?*:eTn::
:?*:ÈTn::
:?*:ËTn::
:?*:aTn::
:?*:qTn::
:?*:bTn::
:?*:cTn::
:?*:dTn::
:?*:fTn::
:?*:gTn::
:?*:hTn::
:?*:lTn::
:?*:mTn::
:?*:nTn::
:?*:oTn::
:?*:pTn::
:?*:rTn::
:?*:sTn::
:?*:tTn::
:?*:vTn::
:?*:wTn::
:?*:xTn::
:?*:yTn::
:?*:zTn::
HOT_PrintHotstring("aison")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en TO (mention) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:To::
:?*:mTo::
:?*:uTo::
:?*:iTo::
:?*:eTo::
:?*:ÈTo::
:?*:ËTo::
:?*:aTo::
:?*:qTo::
:?*:bTo::
:?*:cTo::
:?*:dTo::
:?*:fTo::
:?*:gTo::
:?*:hTo::
:?*:lTo::
:?*:mTo::
:?*:nTo::
:?*:oTo::
:?*:pTo::
:?*:rTo::
:?*:sTo::
:?*:tTo::
:?*:vTo::
:?*:wTo::
:?*:xTo::
:?*:yTo::
:?*:zTo::
HOT_PrintHotstring("ion")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en TQ (mentique) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:mTq::
:?*:uTq::
:?*:iTq::
:?*:eTq::
:?*:ÈTq::
:?*:ËTq::
:?*:aTq::
:?*:qTq::
:?*:bTq::
:?*:cTq::
:?*:dTq::
:?*:fTq::
:?*:gTq::
:?*:hTq::
:?*:lTq::
:?*:mTq::
:?*:nTq::
:?*:oTq::
:?*:pTq::
:?*:rTq::
:?*:sTq::
:?*:tTq::
:?*:vTq::
:?*:wTq::
:?*:xTq::
:?*:yTq::
:?*:zTq::
HOT_PrintHotstring("ique")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en TR (menteur) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:Tr::
:?*:mTr::
:?*:uTr::
:?*:iTr::
:?*:eTr::
:?*:ÈTr::
:?*:ËTr::
:?*:aTr::
:?*:qTr::
:?*:bTr::
:?*:cTr::
:?*:dTr::
:?*:fTr::
:?*:gTr::
:?*:hTr::
:?*:lTr::
:?*:mTr::
:?*:nTr::
:?*:oTr::
:?*:pTr::
:?*:rTr::
:?*:sTr::
:?*:tTr::
:?*:vTr::
:?*:wTr::
:?*:xTr::
:?*:yTr::
:?*:zTr::
HOT_PrintHotstring("eur")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en TZ (menteuse) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:Tz::
:?*:mTz::
:?*:uTz::
:?*:iTz::
:?*:eTz::
:?*:ÈTz::
:?*:ËTz::
:?*:aTz::
:?*:qTz::
:?*:bTz::
:?*:cTz::
:?*:dTz::
:?*:fTz::
:?*:gTz::
:?*:hTz::
:?*:lTz::
:?*:mTz::
:?*:nTz::
:?*:oTz::
:?*:pTz::
:?*:rTz::
:?*:sTz::
:?*:tTz::
:?*:vTz::
:?*:wTz::
:?*:xTz::
:?*:yTz::
:?*:zTz::
HOT_PrintHotstring("euse")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en Y (ille) :
;;;;;;;;;;;;;;;;;;;;;;;
:?*:iY::
HOT_PrintHotstring("lle")
Return
:?*:qY::
HOT_PrintHotstring("uille")
Return
:?*:aY::
:?*:bY::
:?*:cY::
:?*:dY::
:?*:eY::
:?*:ÈY::
:?*:ËY::
:?*:fY::
:?*:gY::
:?*:hY::
:?*:jY::
:?*:kY::
:?*:lY::
:?*:mY::
:?*:nY::
:?*:oY::
:?*:pY::
:?*:rY::
:?*:sY::
:?*:tY::
:?*:uY::
:?*:vY::
:?*:wY::
:?*:xY::
:?*:yY::
:?*:zY::
HOT_PrintHotstring("ille")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en YA (illant) :
;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:iYa::
:?*:qYa::
:?*:aYa::
:?*:bYa::
:?*:cYa::
:?*:dYa::
:?*:eYa::
:?*:ÈYa::
:?*:ËYa::
:?*:fYa::
:?*:gYa::
:?*:hYa::
:?*:jYa::
:?*:kYa::
:?*:lYa::
:?*:mYa::
:?*:nYa::
:?*:oYa::
:?*:pYa::
:?*:rYa::
:?*:sYa::
:?*:tYa::
:?*:uYa::
:?*:vYa::
:?*:wYa::
:?*:xYa::
:?*:yYa::
:?*:zYa::
HoT_PrintHotstring("ant", 1)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en YB (illable) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:iYb::
:?*:qYb::
:?*:aYb::
:?*:bYb::
:?*:cYb::
:?*:dYb::
:?*:eYb::
:?*:ÈYb::
:?*:ËYb::
:?*:fYb::
:?*:gYb::
:?*:hYb::
:?*:jYb::
:?*:kYb::
:?*:lYb::
:?*:mYb::
:?*:nYb::
:?*:oYb::
:?*:pYb::
:?*:rYb::
:?*:sYb::
:?*:tYb::
:?*:uYb::
:?*:vYb::
:?*:wYb::
:?*:xYb::
:?*:yYb::
:?*:zYb::
HOT_PrintHotstring("able", 1)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en YE (illence) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:iYe::
:?*:qYe::
:?*:aYe::
:?*:bYe::
:?*:cYe::
:?*:dYe::
:?*:eYe::
:?*:ÈYe::
:?*:ËYe::
:?*:fYe::
:?*:gYe::
:?*:hYe::
:?*:jYe::
:?*:kYe::
:?*:lYe::
:?*:mYe::
:?*:nYe::
:?*:oYe::
:?*:pYe::
:?*:rYe::
:?*:sYe::
:?*:tYe::
:?*:uYe::
:?*:vYe::
:?*:wYe::
:?*:xYe::
:?*:yYe::
:?*:zYe::
HOT_PrintHotstring("nce")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en YQ (illique) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:iYq::
:?*:qYq::
:?*:aYq::
:?*:bYq::
:?*:cYq::
:?*:dYq::
:?*:eYq::
:?*:ÈYq::
:?*:ËYq::
:?*:fYq::
:?*:gYq::
:?*:hYq::
:?*:jYq::
:?*:kYq::
:?*:lYq::
:?*:mYq::
:?*:nYq::
:?*:oYq::
:?*:pYq::
:?*:rYq::
:?*:sYq::
:?*:tYq::
:?*:uYq::
:?*:vYq::
:?*:wYq::
:?*:xYq::
:?*:yYq::
:?*:zYq::
HOT_PrintHotstring("ique", 1)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en YR (illeur) :
;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:iYr::
:?*:qYr::
:?*:aYr::
:?*:bYr::
:?*:cYr::
:?*:dYr::
:?*:eYr::
:?*:ÈYr::
:?*:ËYr::
:?*:fYr::
:?*:gYr::
:?*:hYr::
:?*:jYr::
:?*:kYr::
:?*:lYr::
:?*:mYr::
:?*:nYr::
:?*:oYr::
:?*:pYr::
:?*:rYr::
:?*:sYr::
:?*:tYr::
:?*:uYr::
:?*:vYr::
:?*:wYr::
:?*:xYr::
:?*:yYr::
:?*:zYr::
HOT_PrintHotstring("ur")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en YS (illesse) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:iYs::
:?*:qYs::
:?*:aYs::
:?*:bYs::
:?*:cYs::
:?*:dYs::
:?*:eYs::
:?*:ÈYs::
:?*:ËYs::
:?*:fYs::
:?*:gYs::
:?*:hYs::
:?*:jYs::
:?*:kYs::
:?*:lYs::
:?*:mYs::
:?*:nYs::
:?*:oYs::
:?*:pYs::
:?*:rYs::
:?*:sYs::
:?*:tYs::
:?*:uYs::
:?*:vYs::
:?*:wYs::
:?*:xYs::
:?*:yYs::
:?*:zYs::
HOT_PrintHotstring("sse")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en YT (illement) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:iYt::
:?*:qYt::
:?*:aYt::
:?*:bYt::
:?*:cYt::
:?*:dYt::
:?*:eYt::
:?*:ÈYt::
:?*:ËYt::
:?*:fYt::
:?*:gYt::
:?*:hYt::
:?*:jYt::
:?*:kYt::
:?*:lYt::
:?*:mYt::
:?*:nYt::
:?*:oYt::
:?*:pYt::
:?*:rYt::
:?*:sYt::
:?*:tYt::
:?*:uYt::
:?*:vYt::
:?*:wYt::
:?*:xYt::
:?*:yYt::
:?*:zYt::
HOT_PrintHotstring("ment")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en YZ (illeuse) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:iYz::
:?*:qYz::
:?*:aYz::
:?*:bYz::
:?*:cYz::
:?*:dYz::
:?*:eYz::
:?*:ÈYz::
:?*:ËYz::
:?*:fYz::
:?*:gYz::
:?*:hYz::
:?*:jYz::
:?*:kYz::
:?*:lYz::
:?*:mYz::
:?*:nYz::
:?*:oYz::
:?*:pYz::
:?*:rYz::
:?*:sYz::
:?*:tYz::
:?*:uYz::
:?*:vYz::
:?*:wYz::
:?*:xYz::
:?*:yYz::
:?*:zYZ::
HOT_PrintHotstring("use")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en Z (euse) :
;;;;;;;;;;;;;;;;;;;;;;;
:?*:eZ::
HOT_PrintHotstring("use")
Return
:?*:qZ::
HOT_PrintHotstring("ueuse")
Return
:?*:aZ::
:?*:bZ::
:?*:cZ::
:?*:dZ::
:?*:ÈZ::
:?*:ËZ::
:?*:fZ::
:?*:gZ::
:?*:hZ::
:?*:iZ::
:?*:ÓZ::
:?*:jZ::
:?*:kZ::
:?*:lZ::
:?*:mZ::
:?*:nZ::
:?*:oZ::
:?*:pZ::
:?*:rZ::
:?*:sZ::
:?*:tZ::
:?*:uZ::
:?*:vZ::
:?*:wZ::
:?*:xZ::
:?*:yZ::
:?*:zZ::
HOT_PrintHotstring("euse")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Suffixe en ZT (eusement) :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:?*:eZt::
:?*:qZt::
:?*:aZt::
:?*:bZt::
:?*:cZt::
:?*:dZt::
:?*:ÈZt::
:?*:ËZt::
:?*:fZt::
:?*:gZt::
:?*:hZt::
:?*:iZt::
:?*:ÓZt::
:?*:jZt::
:?*:kZt::
:?*:lZt::
:?*:mZt::
:?*:nZt::
:?*:oZt::
:?*:pZt::
:?*:rZt::
:?*:sZt::
:?*:tZt::
:?*:uZt::
:?*:vZt::
:?*:wZt::
:?*:xZt::
:?*:yZt::
:?*:zZt::
HOT_PrintHotstring("ment")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

:?*:Aa::
HOT_PrintHotstring("en temps", 3)
Return
:?*:Ra::
HOT_PrintHotstring("rrant", 2)
Return
:?*:Ga::
HOT_PrintHotstring("Èant", 2)
Return
:?*:Ha::
HOT_PrintHotstring("ant", 1)
Return
:?*:La::
HOT_PrintHotstring("hÍlant", 4)
Return

:?*:Ab::
HOT_PrintHotstring("en table", 3)
Return
:?*:Rb::
HOT_PrintHotstring("Èrable", 3)
Return
:?*:Eb::
HOT_PrintHotstring(" sable", 2)
Return
:?*:Hb::
HOT_PrintHotstring("h‚chable", 4)
Return

:?*:Re::
HOT_PrintHotstring("rrance", 2)
Return
:?*:Ee::
HOT_PrintHotstring("nce")
Return
:?*:Ge::
:?*:Se::
HOT_PrintHotstring("nce")
Return
:?*:Ze::
HOT_PrintHotstring("aisance", 4)
Return

:?*:Lg::
HOT_PrintHotstring("hÍlage", 4)
Return

:?*:Rj::
HOT_PrintHotstring("orgie", 3)
Return
:?*:Jj::
HOT_PrintHotstring("gi", 1)
Return

:?*:El::
HOT_PrintHotstring(" selle", 2)
Return
:?*:Rl::
HOT_PrintHotstring("oreille", 3)
Return
:?*:Sl::
HOT_PrintHotstring("aisselle", 4)
Return
:?*:Tl::
HOT_PrintHotstring("-elle")
Return

:?*:Gm::
HOT_PrintHotstring("isme", 1)
Return
:?*:Hm::
HOT_PrintHotstring("schisme", 4)
Return
:?*:Om::
HOT_PrintHotstring("sionisme", 4)
Return

:?*:En::
HOT_PrintHotstring(" saison", 2)
Return
:?*:Rn::
HOT_PrintHotstring("oraison", 3)
Return

:?*:Bo::
HOT_PrintHotstring("ation", 1)
Return
:?*:To::
HOT_PrintHotstring("ion")
Return

:?*:Aq::
HOT_PrintHotstring("ique")
Return
:?*:Oq::
HOT_PrintHotstring("sionique", 4)
Return
:?*:Yq::
HOT_PrintHotstring("dyllique", 3)
Return

:?*:Hr::
HOT_PrintHotstring("ur")
Return
:?*:Rr::
HOT_PrintHotstring("horreur", 3)
Return
:?*:Tr::
HOT_PrintHotstring("eur")
Return

:?*:Lt::
HOT_PrintHotstring(" ment")
Return
:?*:Rt::
HOT_PrintHotstring("rrement", 2)
Return

:?*:Ay::
HOT_PrintHotstring("ill")
Return
:?*:Gy::
HOT_PrintHotstring("ile", 1)
Return

:?*:Hz::
HOT_PrintHotstring("use")
Return
:?*:Rz::
HOT_PrintHotstring("heureuse", 3)
Return
:?*:Tz::
HOT_PrintHotstring("euse")
Return

; Suffixes par dÈfaut :
:?*:A::
HOT_PrintHotstring("ant")
Return
:?*:B::
HOT_PrintHotstring("able")
Return
:?*:E::
HOT_PrintHotstring("ence")
Return
:?*:G::
HOT_PrintHotstring("age")
Return
:?*:H::
HOT_PrintHotstring("chie")
Return
:?*:J::
HOT_PrintHotstring("gie")
Return
:?*:L::
HOT_PrintHotstring("elle")
Return
:?*:M::
HOT_PrintHotstring("isme")
Return
:?*:N::
HOT_PrintHotstring("naison")
Return
:?*:O::
HOT_PrintHotstring("tion")
Return
:?*:Q::
HOT_PrintHotstring("ique")
Return
:?*:R::
HOT_PrintHotstring("eur")
Return
:?*:S::
HOT_PrintHotstring("esse")
Return
:?*:T::
HOT_PrintHotstring("ment")
Return
:?*:Y::
HOT_PrintHotstring("ille")
Return
:?*:Z::
HOT_PrintHotstring("euse")
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#Hotstring C0 B0
#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; New hotstring { Win + H } :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

HOT_NewHotstring:
^+#h::
HOT_NewHotstring()
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

HOT_NewHotstring() {
	
	Global AHK_ScriptInfo
	AutoTrim, Off
	LOC_ClipBoard := ClipBoardAll
	If (!TXT_SelectToClipBoard(PRM_Copy := 1)) {
		TXT_SetClipBoard(LOC_ClipBoard)
		AutoTrim, On
		Return
	}

	; Replace CRLF and/or LF with `n for use in a "send-raw" hotstring:
	StringReplace, LOC_Hotstring, ClipBoard, ``, ````, All  ;
	StringReplace, LOC_Hotstring, LOC_Hotstring, `r`n, ``r, All
	StringReplace, LOC_Hotstring, LOC_Hotstring, `n, ``r, All
	StringReplace, LOC_Hotstring, LOC_Hotstring, %A_Tab%, ``t, All
	StringReplace, LOC_Hotstring, LOC_Hotstring, `;, ```;, All
	TXT_SetClipBoard(LOC_ClipBoard)
	AutoTrim, On

	; Show the InputBox, providing the default hotstring :
	SetTimer, HOT_MoveCaretTimer, -50 ; Will simply move cursor at the 3rd position in the input box
	InputBox, LOC_HotstringDefinition, New Hotstring, Type your abreviation at the indicated insertion point. You can also edit the replacement text if you wish.`n`nExample entry: :R:btw`::by the way,,,,,,,, :R:`::%LOC_Hotstring%
	If (ErrorLevel != 0) {
		Return
	}
	IfInString, LOC_HotstringDefinition, % ":R`:::"
	{
		MsgBox, 48, Wrong hotstring - %AHK_ScriptInfo%, You didn't provide a correct hotstring, 4 ; Exclamation & OK button
		Return
	}

	Try {
		FileAppend, `n%LOC_HotstringDefinition%, %A_ScriptDir%\hotstrings.ahk ; Put a `n at the beginning in case file lacks a blank line at its end
	} Catch LOC_Exception {
		AHK_Catch(LOC_Exception, "HOT_NewHotstring")
	}
	ADM_Reload()
	Sleep, 200
	MsgBox, 36, Hotstring improperly formatted - %AHK_ScriptInfo%, Would you like to edit the end part of the script ?, 10 ; Question & Yes/No buttons
	IfMsgBox, Yes, GoSub, ADM_Edit
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

HOT_MoveCaretTimer:
IfWinActive, New Hotstring ahk_class #32770
{
	SendInput, {Home}{Right 3}
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Hotstrings initialization :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

HOT_InitGroups() {

	Global
	; GroupAdd, HOT_HotstringsWindowsGroup, UEStudio ; UltraEdit
	GroupAdd, HOT_HotstringsWindowsGroup, UltraEdit ; UltraEdit
	GroupAdd, HOT_HotstringsWindowsGroup, Notepad++ ahk_class Notepad++ ; Notepad++
	GroupAdd, HOT_HotstringsWindowsGroup, ahk_class MozillaWindowClass ; Mozilla
	GroupAdd, HOT_HotstringsWindowsGroup, ahk_class OpusApp ; Office
	GroupAdd, HOT_HotstringsWindowsGroup, ahk_class XLMAIN ; Excel
	GroupAdd, HOT_HotstringsWindowsGroup, ahk_class rctrl_renwnd32 ; Outlook
	GroupAdd, HOT_HotstringsWindowsGroup, KGS ahk_class SunAwtFrame ; KGS
	GroupAdd, HOT_HotstringsWindowsGroup, ÈvËnement ahk_class MozillaDialogClass ; Thunderbird
	GroupAdd, HOT_HotstringsWindowsGroup, EditEmailSubject - Editer le sujet du message ahk_class MozillaDialogClass ; Thunderbird
	GroupAdd, HOT_HotstringsWindowsGroup, ahk_class Chrome_WidgetWin_1 ; Chrome
	GroupAdd, HOT_HotstringsWindowsGroup, ahk_class IEFrame ; IE
	GroupAdd, HOT_HotstringsWindowsGroup, heure de dÈbut ahk_class SWT_Window0 ; Sametime
	GroupAdd, HOT_HotstringsWindowsGroup, ahk_class IMWindowClass ; Lync
	GroupAdd, HOT_HotstringsWindowsGroup, ahk_class HwndWrapper[TabbedConversations.exe;; ; Lync
	GroupAdd, HOT_HotstringsWindowsGroup, New Defect ahk_class TNewBugForm ; Quality Center
	GroupAdd, HOT_HotstringsWindowsGroup, Required Defect Fields ahk_class TRequiredFieldsDlg ; Quality Center
	GroupAdd, HOT_HotstringsWindowsGroup, Edit Text ahk_class #32770 ; SnagIt
	GroupAdd, HOT_HotstringsWindowsGroup, ahk_class DSUI:PDFXCViewer ; PDF-XChange
	GroupAdd, HOT_HotstringsWindowsGroup, ahk_class Sticky_Notes_Note_Window ; Windows 7 Sticky Notes
	GroupAdd, HOT_HotstringsWindowsGroup, Nox App Player ahk_class Qt5QWindowIcon ; Nox
	GroupAdd, HOT_HotstringsWindowsGroup, ahk_class WordPadClass ; WordPad
	GroupAdd, HOT_HotstringsWindowsGroup, Skype ahk_class tSkMainForm ; Skype
	GroupAdd, HOT_HotstringsWindowsGroup, ahk_class TConversationForm ; Skype
	GroupAdd, HOT_IgnoringWindows, ahk_class Progman
	GroupAdd, HOT_IgnoringWindows, ahk_class Shell_TrayWnd
	GroupAdd, HOT_IgnoringWindows, ahk_class VistaSwitcher_SwitcherWnd
	GroupAdd, HOT_IgnoringWindows, ahk_class AutoHotkeyGUI
	, AHK_CapsLockTickCount := 0
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Ajouts automatiques :
;;;;;;;;;;;;;;;;;;;;;;;;
