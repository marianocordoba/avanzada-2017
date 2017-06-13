-- Se importa Data.Char para acceder a funciones de manejo de caracteres ASCII
import Data.Char

-- Se define el tipo Bit
data Bit = O | I deriving (Eq, Show)

-- Tamaño de la clave
keySize :: Int
keySize = 8

xor :: Bit -> Bit -> Bit
xor I I = O
xor O O = O
xor _ _ = I

-- Aplica xor a listas
lxor :: [Bit] -> [Bit] -> [Bit]
lxor [] _ = []
lxor xs [] = xs
lxor (x:xs) (y:ys) = [x `xor` y] ++ xs `lxor` ys

-- Convierte un entero en una lista de bits
intToBits :: Int -> [Bit]
intToBits 0 = [O]
intToBits 1 = [I]
intToBits n = intToBits (n `div` 2) ++ intToBits (n `mod` 2)

-- Convierte una lista de bits en un entero
bitsToInt :: [Bit] -> Int
bitsToInt [] = 0
bitsToInt [O] = 0
bitsToInt [I] = 1
bitsToInt xs = bitsToInt [last xs] + 2 * bitsToInt (init xs)

-- Completa una lista de bits hasta la longitud deseada
pad :: [a] -> a -> Int -> [a]
pad [] _ _ = []
pad xs x n
  | length xs == n = xs
  | length xs < n = pad (x:xs) x n

-- Convierte un caracter en una lista de 7 bits
charToBits :: Char -> [Bit]
charToBits c = pad (intToBits (ord c)) O 7

-- Convierte una lista de 7 bits en un caracter
bitsToChar :: [Bit] -> Char
bitsToChar xs 
  | length xs /= 7 = error "Valor inválido" 
  | otherwise = chr (bitsToInt xs)

-- Convierte un texto a una lista de bits
textToBits :: [Char] -> [Bit]
textToBits [] = []
textToBits (x:xs) = charToBits x ++ textToBits xs

-- Convierte una lista de bits a texto
bitsToText :: [Bit] -> [Char]
bitsToText [] = []
bitsToText xs = [bitsToChar (take 7 xs)] ++ bitsToText (drop 7 xs)

-- Particiona una lista de bits en "chunks"
split :: [Bit] -> Int -> [[Bit]]
split [] _ = []
split xs n = [take n xs] ++ split (drop n xs) n

-- Concatena una lista de "chunks" en una lista de bits
join :: [[Bit]] -> [Bit]
join [] = []
join (x:xs) = x ++ join xs

-- Encripta una lista de "chunks"
encryptChunks :: [[Bit]] -> [Bit] -> [[Bit]]
encryptChunks xs ks = fst (encryptChunks' xs ks)

encryptChunks' :: [[Bit]] -> [Bit] -> ([[Bit]], [Bit])
encryptChunks' [] _ = ([], [])
encryptChunks' xs c = (a ++ [e], e)
  where (a, b) = encryptChunks' (init xs) c
        x = last xs
        e = (x `lxor` b) `lxor` c

-- Desencripta una lista de "chunks"
decryptChunks :: [[Bit]] -> [Bit] -> [[Bit]]
decryptChunks xs ks = fst (decryptChunks' xs ks)

decryptChunks' :: [[Bit]] -> [Bit] -> ([[Bit]], [Bit])
decryptChunks' [] _ = ([], [])
decryptChunks' xs c = (a ++ [e], x)
  where (a, b) = decryptChunks' (init xs) c
        x = last xs
        e = (x `lxor` b) `lxor` c

-- Encripta un texto
encrypt :: [Char] -> [Bit] -> [Char]
encrypt [] _ = []
encrypt xs ks = bitsToText (join (encryptChunks (split (textToBits xs) keySize) ks))

-- Desencripta un texto
decrypt :: [Char] -> [Bit] -> String
decrypt [] _ = []
decrypt xs ks = bitsToText (join (decryptChunks (split (textToBits xs) keySize) ks))

test :: String
test = decrypt "g\t\f\"/W\v,CIm#;4'4\EMs\NAK&it\v8\GS8Un\\yZ]*PiEFfl\r\f4qED%o\RS)'\GS=}5;4\DC1<W}U(f?U\\gFGh\t8\SYN:QX\ACKRS\SOH\DLE:\\_E0%.\US9U\rd8|\ETXIOn\SOH/R\CAN X\ESCF\ENQ)\ENQ9{>-W\SYNr<i\DC1\t`<d\fZ\DC2&^\SI]\SO-Q\DC3r).\SUBx\SI\STX$2I\RSFVAu\t\DEL/|w@L#pAaA %4_P@c\r\ACK1;\ESC:zz\n\NUL4$_XWj\a]\ESCt\DEL@\\i\SONG\b\r\DEL\SYN\SO;P\\\SOH]\USo'd6j\DC1Y^Om\EOT#j]i\SIz6'\DC4~UM\GSk3d{^Dt\b;\\Nw\SI\DEL3(u>lqH\SOT]\NAK\ETB9\ENQ3p(j\NAKOGfG\b\SIq\DC1\EOTquNOg\EOTe6}\DEL\SO-D\US(\DC4=EVNd\NUL=R^&T\bHD\SO\ETX5\FS(~iOV;6RD\rB\SOH:UX r\SYN\\\FS4W\ETB\SOH12\DC4q\STXE\STX\r\DELT=g[+k9hZaQ@48P]\SYN\SI{W*'[\ETBew\FSiuP1i]?(y8|rY\DC3\RS3~{;\FS?u--|2.M\DC2kuHEgEk\ETXy6<0T\f\SIqS/.>]\SO\SOHy\SYN\ACKx\ACK\a%\t1d2g\t@ZeB\vN\SUB3\GS~3nRaG\n\NULr|E\v\SOH>6S\RS\SOHq\\/)=\ESCq5nT{\SIy9}w\USj w\RS\n%W\ACK)S\RSjx\vZ\FS \EM>a|M{\fz}^\ACKS\DC3\ENQv^fEK'n2fYd\t*\EM*\\I\SI\ESCs\DLE\CAN6SI\SO\SYNq\DC4N=^\ETB-S\SUBp<\SOOT\NUL`L\v\SOHe::wx\ESC(\FS|xNMw\FSi~HaW\SOH\SYN-*\ETB?\DC396\t\DELB-d/qW/6geEeFh\DELI\r\vqq\CANns_\ACK\DLE;GWO-01YP.v\SYNF\DC1'\CANl?m]&$w?y=/o7iJ 1\DC1=x*h]bJ\DEL\v\DEL()1\DC3u4+;X\b$Q\NAK\SYN-|/j\FSG\DLE\DC3kZ$ 8LZ$R\nMQ\SOH\DC3t!a\SUB\a\DEL\SUBI\DC4\SYNk_#72\SO0TS\ACK\STX3$\EM~>j\tDP\rKC<&<\ESCzRk\STX\ve\CAN\ACK\DELV\STX!\ETB\DELw?*{pDx\ACKiP\SOn}\ENQ\ENQ3g/eS(&MSPmIX+/^\SI%\DC2{\a\ACK|r\r-\NULr\DC1X\RS@]\STX\DLEcVo$\SI3}2%>\SI,RS\n\SOpQxFoZ\aD\NAK$\ETB7R\t!U\ESCe:c8 3QZShJ`\t>\bs\ETX\NUL`oFM#x\NAKLA}JZfB\NULE\RS\SOHqVnR\SIVUgGA$67\US\DEL3(p=b]kU&5p)n[)k=8}5hixK~\SOmd\ENQ9\GS<\EOTy\ESC\rtGoD?+l;`Vd@}BNkU\ETX\rq0(-\DC3:z}L;aU:(5J\ETBV\ETB(\STX3'\SYNj<~\SUBG\DC1l'\"\DLE<;^]\ACKG\SYN\r}PmPIiH*:ww\GS'\EOTuv\STX.V\EM0\DC2=V\SYN3\FS(5_Im\ETXe.*2X^uFFsGNc\DC3\SI it\ESC7_\NAK\STX%(\DLEh\CANF\ENQG\SO$\ETBiX:?S\t{9\"8A\GS\DC2)6^\\\DC4\SO\"]VM#\"k1\"\nt\NULPN\vE\\>\"{q\EOTnk\SI\SI&jdI\SI\SIpq[B%lKi\bM\DC2$~YE1c4\"{p\v:\FS|cJ\SI@\ETBb%!\DLE8vxA\ESCE\ETBB\SOH\"\DC1c\CAN\ESC>\US\DEL\ESCHQ(\EOTpx[\tF\ENQk?l+tBeL\ETX\ENQq?/=\SI'u+e7*?M\GSk=,\FSu\GS\SOu\FS\ftz]E`B*D\EOT\vbT/cY:/J\ETX$\STXq\GS\SI5\ESC8r<b\ETB[\US\ENQ9{=w\DC2\f:P\FS%DP,@\\'EI&&3SHmUA6i\SUB\f:QNBqY\ENQ\DC1s$.}s\STX{9c7!\DEL#o\RS\ACK>EB\vP\US)\NUL~s\r{=>s={=&uv\a-ROaDNmVEoS%fQd\ro;f) u{\ve\"jy[\a\a?r}\EOT\STXfYn\n#Q\SUB\STXz\ENQS\SO`qDki[h\DC4&Z\RSO]A!bWa\STX\RSr\NULL@\NULJ\DLE\SOH`_x\ETX;YI$2;\CAN6;J\ETBP\EM*\DC1nWyK?k\ETB\v/}?}#i\RS\ENQv\DC2N\SUBQN^o\t-\ACKypL?[\FSld\tA\CANc9\fnt\SIG\EMu:<~7i<$<\ESCwWoM.'y4)3\EOT0U[Q\"77\ESC?\ETB;z1xP~\RS\ACKv\FSD^\SOH\EOTdsH\SOJX\aEY1?5\DLE<woJ#w\DC1\f:0\FS)S\DC4mc\f}nDeR\ETXB\DC2-[S)%k~M-\ae{\SOHor\ETX)\DC48[V\SOHF\GS(\ETX6R[\NAK\ACK4=^N\"%-\GS(trK\DEL\EOTerK\ETX\ETX3\CAN1!U\SOHf\"-X\GS6^^\tUK%(m3)x?,\DC1<`z\SI)\STX|`\EOT=KY\ENQ2c}JJl@\fQ\SON\\\STX\EOTd\DC3HEnOM\"-;Y|>g\ESC\avA$f{_J5z]~H!$os\CAN%OZ1b\\+A[&etN/S\FS`}\STX\ESC71*/;\ETB97&u}\ETX(\a0\STX5>\DC3uV;6_UI/ 9P_&&=T\b9]Xe`HnA\ACKG\DLE\DC2=<\DC2h]bFcW\rC\DC2nwI/1}.\"0HVjH\ETX\EOT$4\RS1X\SO(\DC1{@d\"Y_\ENQ\"-;B\DC3A\SUBc4<?^\GSO\FStz\\Gh@)tXl\EOT\CANI\NAK\b&0QVG*Ej\ACK.[QR(5\DC3*zjBHf\bCTLo\\\aCR3e]/k\FS(/R\US*P[\n\ENQp\ETBmS()}2jlR\ACKHS\EOTF\ENQDV\t@\EOT.\DC3/\SYN:wm\ENQf2k~\STX9M\FSctQ-bhtX\DC1I[&\")\DC1h\SIMPo\ETX,*h\b\NUL:UZ\aD\NAK7\vr\"%;\ETB4v?,\DC1x\SYNBZ\DC2HVjD\SUBM\CAN%pXjE\aF\FS>\ESC3\DC18:\US=d7 \GS:Uf\r-\GS<\CANv\DC4\SIqP5spK\SO\fpQxFoM\f\DC4}W,euNNgMJ#1\DLE(;\CAN1$\EOTpsDZ|D\SIBJ!tQ\DEL\EMl7:T]\v\r2\DELiR!fUvI\EM\av7{_/7<]\\\ACKc[<$:MT7fTj\a\f\DLE5W\DLE\"CRS-w&.1QZMl\EOTC\\W.1&\DC2>XKCd\SOH:Y\n\EOTsS$/<\CAN7F\EOThrJ\NULH\DC3DV\NAKG\DC4#\\N|O\RS\SUBp\USXW`\b+\DLE.)UV6f\FSX\RS$S\SI\EM=q3k_#j0h\SYNA]CeA'#;\ESC0|s\ENQ\fr\FSM\DC4br\SO\SOr\a\ACK%3\DC4jhYK4 +T])`\SUBkHCqC&26\RSo\ESC\bryFN\"w\SUB\ft~J\ACKH\SYN1HYw\SYN!a\NAKf;9\DLE|\EMF\ETX-RBmCY:o\SO\STX JT\EOT\t6WnFb\ENQ1\CAN?$V\rG\DC2#v\b*V\DLEO@OqJDg\ENQK\SYNhgDE&ww\GS}{\ETXa\"fvVAf\SO#WP/f]+%r/1\EM<ufL\USJE\DEL\STXna\STXid\NULk@M#\ACKdrP!fLw\tc:x5gMc\DC4bfA|\EOT,VK\US\USr?o\GS\US5r)f)oP(r\CANA\FS\NUL4!@\ESC0\EM~3uS)6f~\STXFV\r\ETX$zjGh\ENQ!\ESC85NYd\b P^Fa\r\GSzCl\ENQ?[^3yC)(3\GS^/o_%`Nb\DLE\SOHs\\\"m\CANH\STXG\ETBc1jYdE}\SIc ;y7g?k\DC3LEZxB(aZ:n\nI\DC3\DC2}\ETB\ESC-v0?EVOw\EOTiuZh\NUL+^\EMe7)\v4bm\EOTy}_6*<OTAhC(!=\RS}\DC1\ETXay\t.\SUBp\DC3O\\3-4\v\DELSmk0(~NZ\vJ\ETBJ\CAN+C\SYNnuH%g]k\bcyWb\ETB$\SYNz\FSO\DC1AE\ESCXWYhGd\STXkV\v#\DC1us\SUBfe\NULn|\ENQE\DC1\"\NUL}W-ay\FSlz]\DC3\DC45G\USw;*<\SYNy&t\\+fT.,RM\ETX\SYN->\NAK,_UU\"!<\bl?\DEL].e\US\nc}J@c\ETX`=?VX\ENQH\ESC-\FS{4!<[^Aa\ENQEVup\EOT,G\DC4\DLE<6[XDhF~DHvH\n\SOH;\SUBy>\NAKzVf\NAKL\FSdvG\SOC1\b'8\rqC~\rN\GS UJYeO;;7\DC1<7K_#e[',vq\rO\SYNw{\SOH}z[v\SO;]\DLEmwMo\STXgzO\SOH\DC2~d\ACK=S\RS&d\bDD\r\rtg\DELHmJFu\\Hr\DC2\NULu\RS\SO50\DC49G\SYNb`G\CANH\EMCUm!l\USiO\"'6^\DEL\ETB\bqx\ACK:\CAN|\DC2N\DC4NVAj\t.\SYNyt\t/\ESC11\b~s\ro:&?]\FS\DC3rCm\a*\RS;\DC4=;\SYN/;\vd:}\GS\EOT>m2jrIN6a\FSJ\CANITEuHKnIfG\SUB\GSxQiH!}\DC4\ty@*#\CAN,4ZV\DLE\f&_VHoL\\i\ETX\ACK45LT\nOU4+3\US2}\DEL\r\v4}z\SOH-\\\FS\aYIa\ra1*\DC4\DEL\DC1M\NAK#\CANqc\NUL*QNZl\nXQ\DC4\n73\bryMB'd\ESC]T\"k_%,{9F+l\FSlE\ACK\NUL7WS\ETX\a>{tGd\n6\RSv\FSE\a\EOTv\DLE^\GS3\NAK}w(\DEL|\n)B\GS\a\US`u@Ln\SOH\t6~hR\b\NUL3DV5W\FS'~[}Jmf\DC2(\DLEv2l\\xC\t\fx5gW b\ETBA\DC2\DC4v\DC4\SIW[>lkDZ(t\FSK\DC3[YG(\"xp\SI\SO *_VG'v;}\\kTLo\NULIQW:'5\f}c\FS(\DC1|XzOf\STXkx\SI*Q\SO\v\DELQ(\"xl\fJ\DC1%\SYN+8\GS2P]\DLEMvSj\ao\rhqL@vIk\SO\DELn\FSgn@hR\DLE\SOH2qrO.+>\RS=?\RSqa\SOHnrD\aC\DC3(/1\DLE;:Y\ETB\fr\aN\DLEag@$c[\",=\SUB}r\v \at\DC3YV#q\FSKyZ>mk\to&a\DC1\t6\ENQwBdH\EOTK\EOT\SO\DEL\DC3L\DC32\DC2,VQ\ENQG\RSjuH,l\CAN\teO*a\DELKF(&.[\SUBD\\\vI\CANqo\tM\ACKapJ\ACKH\DC4\ETXbZ{\SIc4aw\ETXr|O\SI\DC1h4k\ESCH\EM+QX<*7W\n,K\CAN\DLEr\DC4JD\US\vd4`V.V\ETXH\SYNeGD g\USE\DLE#jKhF\fC\a\STX0 \NAKy[-$\b\DEL\ESCH\SOH,\NUL7\DC22=\ESC)x*>\SYNy\EOT\SOp\USOY<j\vE\STXee\NUL\RSr\aNU!\GSp3b\ESCI\CANa4N|E\f\f:tJ\USC\f,_TUkCh\SI#T\f'R\ESCl\v#\CAN~\US_N+mZd\NUL Z_H\ENQ%\NAK=ev\SUB\EOTT\SOHB\NUL![Kl0=LT\tUK8h\FSNY\n\SYNyW\RSb4M\SOH\NUL<\ETB?2=,iuZ=*qt\v)PMj\r XM\US\EOT{q\STX+W\FSidLjI\SOH\a3y,$RNMN\adv+U\DC2azCH!1Q57\b3p= \SOr\nS\ESCw>d\DEL\a.RO\ACK\STXsW\RScr\SO<\SUB;Q\USi080XP!SJ4`YxK~\r)\DC2/~/7\a#sfA\SI\ff:K\ACK\nu\FSJ\NULHCK6,-K\ETB\DC22?S\SIkq^) ruE\aGR!hReNI juC\vG<vl\DLEDDHIWO%a*5wrK\r\fp1oR\"p\EOTJ\ETXA\SUB`5`PaB+nS\DEL\EMd8:XAJ5xZgA=\"~:h\SILCa\nh1e]jQd\SOH/\ACK03Q_5n\DLE\r}YhRhEH,e\SI\ETB|%&vx\SOibL`P\DC1\n{T+4\ETXpQd\SOH%\SUBf:y\EM\GS=c:jo\SI-\a9p|+]\FSbqX\ENQQ[7oO'\"wx@`^\NULA\DC2ag\SOH\GS2v>a\FS\v3\EM6v>l\nU\DLE\SOa\DC3\CAN'z;6R\\\bM\DC4j\DELM;!\DELz\SOH,\ESC8\GSxY|\RS.\\\DC3DVIh\b._\b\tyX.%3\DC4u`\SOH&\DLE3~" [O,I,O,O,I,O,O,I]