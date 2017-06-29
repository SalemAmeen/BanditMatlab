function [Y,Xf,Af] = myNeuralNetworkFunction(X,~,~)
%MYNEURALNETWORKFUNCTION neural network simulation function.
%
% Generated by Neural Network Toolbox function genFunction, 12-Apr-2016 14:54:58.
%
% [Y] = myNeuralNetworkFunction(X,~,~) takes these arguments:
%
%   X = 1xTS cell, 1 inputs over TS timesteps
%   Each X{1,ts} = Qx57 matrix, input #1 at timestep ts.
%
% and returns:
%   Y = 1xTS cell of 1 outputs over TS timesteps.
%   Each Y{1,ts} = Qx1 matrix, output #1 at timestep ts.
%
% where Q is number of samples (or series) and TS is the number of timesteps.

%#ok<*RPMT0>

% ===== NEURAL NETWORK CONSTANTS =====

% Input 1
x1_step1.xoffset = [0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0.000458585741972531;7.30795832951447e-05;2.20301263354227e-05];
x1_step1.gain = [9.64359642697788;12.4251552587904;15.3470566941481;4.42549770599559;10.05779140766;6.69317926782073;7.60825092639388;5.06282571935188;7.55121209591225;5.13173551330626;10.9264534142321;14.2780326489259;7.70747799925507;4.61569323070761;8.10433630638271;5.84962007313296;8.86055102858314;8.39162156906033;17.5955816352982;3.8567629088759;17.6838507703619;8.19347381974468;9.07809434775744;4.91110793202511;11.4572422027281;7.53803518219505;14.0555880238197;8.25011247381044;5.71384819410338;10.7991906361131;4.43355727153716;9.4585319530651;4.2107726338439;9.48673528234822;3.68009157494756;7.30723029082213;8.76194202027967;3.59952730290909;5.39323989049559;10.1413758291154;6.9121851449635;7.39176770480003;8.68255891091449;4.25250984713734;6.68473158369442;5.71314497486076;4.78003485863896;3.89993179427538;7.62556165655445;4.22874570928176;3.67963509552015;3.58731777610967;5.81421112905607;2.95260456240603;3.9593595907309;2.74003051628401;5.73136187873812];
x1_step1.ymin = -1;

% Layer 1
b1 = [1.4074297416084001;-1.3221944883070864;-1.1365445399820335;-1.0007967654205805;-0.79874519092657448;0.69229034067181283;-0.53438971364557364;-0.39764998029224291;-0.19826679513368611;0.049126785697778348;0.11298802974795474;-0.20058456413170342;-0.36571363931629736;0.49207781587229837;0.66212763060911983;0.88656417071902571;1.0080157799823179;-1.1669398316961295;1.3165249861118185;-1.5148713213365859];
IW1_1 = [-0.15677639086881978 0.33625870129418439 0.053272344210684552 -0.21530358201676575 -0.18814734719781612 -0.065821785184420098 -0.26441253001612497 -0.20971407042131776 -0.3120890115630382 -0.15736214058656903 -0.52994870299076124 0.46377263532087404 -0.01431431160707824 -0.05176463508563553 -0.25414496440152334 -0.2744147684096569 -0.45346488602602303 -0.30978230471372303 0.075485222643642852 -0.18959455589897689 -0.65950840231531971 -0.14545205351461729 -0.57616528326700844 -0.43259132183372417 0.42910183025539056 0.43174655260304434 0.64588176433185085 0.47971566522800896 0.39908125644691755 0.026566406310969397 0.47894683376074015 0.30997599461634767 0.56336183556833641 0.1302864948517076 -0.076234216037163974 0.074685479045251191 0.55626682134702843 0.13907166337414306 -0.022457343758956166 -0.090483466942981011 0.50827181955019962 0.24798777538148747 0.1100244690940741 0.49741314777978529 0.67499105389808012 0.46648044612696415 0.23429446601843498 0.024135811345098929 -0.1863543622606853 0.13503711048964101 0.28854571239744997 -0.0074549090036050312 -0.47759701722584286 -0.24473621508972995 -0.25952037261272354 -0.15730187706352455 -0.44281038967049191;0.046237017937256424 0.33513894725865651 -0.25760168271913542 0.2840964726643459 0.11595666628706255 0.24429057116098438 -0.16026647020662979 0.27903532415353721 0.14677395655891584 0.21019769835837079 0.060690773277162838 -0.13615237940134722 0.31915965300026378 0.20209462313994295 0.14651671416518133 -0.031259699882828076 0.29905416946269758 -0.22568102762728068 -0.25162467266910626 -0.062682699654120572 0.29347221893905623 0.043343255217098753 0.1540008808977254 -0.073271221963665228 0.21153104583935942 -0.27164250342280782 -0.13861559848223276 -0.079624064580073095 0.18833581330553051 -0.034126008312472728 -0.22414371477779135 0.15967429122796539 0.17939865124749199 -0.2137601231945431 -0.13312388545309103 -0.11468886791579848 -0.32812244409227875 0.12796976845536759 0.028744905350402486 0.23434895863400593 0.036823817352389369 0.2821107854960011 0.061746899816698841 0.17230669637011509 -0.24763241687592044 -0.084851499577342546 -0.26114600955655776 0.24683207285468914 0.24491247506573821 -0.30606697011706668 0.15099981671654442 -0.12485565951983435 -0.0091854788246938344 0.094381737330068924 -0.044491919797626317 0.32076556514240268 0.08044625357892618;-0.031883753773271697 -0.37319991674373848 0.024015705510415163 -0.22420310384452816 0.35111224343881198 0.35607183001230996 0.54969742714659531 0.27049353384728342 0.36992856137723434 -0.24714931373574744 0.02753778237711758 0.083845249175665867 -0.2177397088445456 -0.22568335791877184 -0.19255224329911244 0.21012374800713435 -0.068419949772810143 -0.0075223169253129801 0.30973492727309693 0.34376623725958749 -0.16299043799108429 0.35448216121693599 0.22090389419254794 -0.14546338677289739 -0.27500505734474956 -0.16774453351613011 -0.10555980921083856 0.21332294877246996 -0.12113371310473227 -0.082538232150004956 -0.031029107140355627 -0.16682646036471702 -0.3826494880415956 -0.34740836821710874 -0.0011888647550632367 -0.2282599677536235 -0.089862199775880891 -0.035009519731202941 -0.076409964399626565 -0.30669396328061821 -0.14746045268610783 -0.041132134425292129 -0.12642043880150405 0.18340260292842023 -0.26286238737997836 0.0010064570661817689 -0.26137487502970991 0.17882198575958891 -0.34384146437976332 0.27094633990009109 0.081830432223348917 -0.12175830511117774 0.41415951503180287 0.15860706826230461 -0.11847446817381993 -0.05665391694169445 0.11085277045450131;0.091309850150781163 0.024832926018941701 0.093801627710173585 -0.0034091423843790902 0.35300293124118809 0.0095343824705436068 0.12697374098659486 0.2795381307047804 0.2939473094153312 -0.26264325751374984 -0.32888437011336202 -0.32311874873420615 0.28859586991504022 0.095160393389131195 -0.031088561878450657 0.35136934922713026 0.24359893000252397 0.077756239536708988 -0.20221311835324371 -0.17104057869103564 -0.31868119709451342 0.24547445687237043 0.35138706895576838 -0.20843582788492571 -0.19914123365573991 -0.24971509978811215 -0.028297573215795277 -0.15780774992795552 -0.28835274726227433 0.020641667068208212 0.28577616140950179 0.085107480080761647 0.21602240904184189 0.27037185480684833 0.087547027989372694 0.17753933363081048 -0.050293225064492686 -0.28070416431196005 0.0040946309567687555 0.13002044845795235 0.26438304383695849 -0.079323187198451481 -0.30947795754740426 -0.30397471225926392 0.093895406698525696 -0.016010844565423784 -0.01962884195376809 -0.28284358197188264 -0.23918798323688323 -0.024782871090773657 0.19836690859803402 0.14868553305282428 0.26591222179371643 -0.1130173622999831 0.20863630750343784 0.032443635562089547 0.34231540134444316;0.23291066042755981 -0.33339247603822059 0.064863424933471373 0.2005755525025554 0.29293554334014826 0.24105157373983685 0.09131061972982292 -0.19825460767741646 0.056538861929773289 -0.085089173481743066 0.026666298588491486 -0.045540219608321657 0.18038176776607115 -0.18133318223543668 -0.16951454241750732 -0.14657930248284254 0.19782476400691582 -0.11821461326497303 -0.056636636294116582 0.18503089548534188 0.02795475509061069 -0.085898320222993693 0.4469189634652283 -0.099919020753370641 -0.33501023528650375 0.036787503382062992 0.057029724803939884 -0.34539116337963038 0.028152300788100847 -0.31759698303187489 0.22826393611241586 -0.34259192984101056 -0.077175765504118296 -0.37476404227533189 -0.0032382467787542965 0.19421215830733193 0.18672282025792536 -0.19254342073390124 -0.42780379917536898 0.26470779856668558 0.10762904913305472 -0.1520496912078079 -0.24445522448890331 -0.079504162920239693 -0.14517231042064521 -0.15631186783239559 -0.078653592765697028 0.17580295482616057 0.14753644513993874 0.25043105779240599 -0.21556528730924734 0.25196815432635172 0.170907237907477 -0.089872100920423942 0.027866030945004505 0.16867005838945756 -0.21943503764565919;-0.003351391370626346 0.21013563775264052 -0.16788947560007952 0.23817742565585293 -0.18881277030263566 -0.2750170162003186 0.29978043757666761 -0.28649724004131122 -0.31270960097319667 -0.12540177704151137 -0.13245197391419064 0.068891028987997427 0.34433370419724646 -0.10730431182366314 0.31529995408176953 0.14745817415898863 0.11674983488513797 -0.1471249982697054 0.1495195231993883 0.32425846969409738 0.18013670511569621 0.19934192277545507 0.14093899678437713 0.18345172710090998 0.32740053305759059 0.33574330454409879 -0.17456805496807679 -0.19628047513101979 -0.044127037739401812 -0.24161718079187935 0.1115662702816783 0.318302392581927 0.093405898367772661 0.13379095342371217 -0.12438674147047675 0.17763570694977066 0.10395049060420881 -0.10579738040560976 0.18246915822631551 -0.11684317096357395 0.31832258572825445 0.2649763008155453 -0.10216859906116588 0.071346559662672893 0.24367669538151662 0.14480749526450093 -0.058741741859118367 0.2994587315342544 -0.05346377709615955 0.13261283721000752 0.2454219323465924 -0.067982592360413069 0.064076294915281704 0.097307617048290149 0.2031001813134734 -0.087854645424612077 -0.08968630903601231;0.17545975275391698 -0.32120426344277858 -0.014423467503033367 -0.10382695583886595 0.26890128539846431 -0.16011795401922566 -0.011179400144673033 -0.18288145691991639 -0.33861736073816023 -0.14448669415397289 -0.0099342420365213738 0.21063495241256247 0.30089148926781178 -0.012241681465544128 -0.11176174255961233 -0.11634840696167754 0.041444703414555854 -0.19611022628863806 0.19483450822074513 0.040987094800933585 -0.20235839808884498 0.1640379792633469 -0.0031409091662699365 -0.076169150407108463 0.18776395746789676 0.3056455080933731 -0.20585496256396005 -0.036346654016498357 0.31133675152380741 -0.0025488129713333932 -0.28356844138383575 -0.024454211207120647 0.15575529613757147 0.30142588084734745 0.27507893428068464 0.20818035476690683 -0.15142095365179339 0.042906991679870665 -0.052475634191513354 0.26450837999419263 0.07080142930314845 -0.098126407297764784 0.23852291909844409 -0.35455298772355259 0.35625585850456487 0.15821090025569609 0.090227980684836992 0.28789753202984669 0.33333262437003641 -0.042227499185602459 0.34612488330615743 -0.095269672136319622 -0.0068700147321536491 0.082697886330681494 -0.082406644179710678 -0.22197003385402395 0.01074927946077796;0.064544998554601232 -0.0044476192837107058 0.038118774012139083 -0.17488094910794763 -0.38004006669718854 -0.34985088017257349 0.056821362815844455 -0.298453968359704 -0.2824865089841323 -0.22715041115133455 -0.08237945821174858 0.16523055053436866 0.0006167826333905443 0.073045635967854405 0.15130280220938283 -0.4611048428890443 -0.46910956885746674 0.16535670407601483 0.070786285580171457 -0.34014844098121999 0.1634363168104212 -0.39241019753653655 0.0019541959233707273 0.15026013356121043 -0.030553798182484992 0.050201215020071355 0.017902825678091715 0.21671621094280866 0.21053076819109531 0.08515350154753315 0.17206126869990745 0.092000184433764731 -0.2561680092266137 0.17868552670164614 0.33865828177176321 0.29942453480506237 -0.23162576781850608 -0.15862019747817374 -0.042551706825108587 -0.10258651900357132 -0.10579899043752541 0.22299043263772136 -0.021542737971365952 -0.21171159404719644 0.3224378877808583 -0.1056977223780622 0.19829382910763835 0.15599815838379869 0.054833262480873418 -0.24992346134736598 0.13277591484449158 0.12003618501249634 0.081503467436486732 0.041780425307287983 0.090383786719479497 -0.35867938971484137 0.015910407865116043;0.38294021375782444 -0.16743568153844579 -0.061692890471270842 -0.15660970248385203 -0.19988429987342307 -0.189902635910149 0.09894538115066788 -0.2365655084217434 -0.17147368012104949 0.18948597535162526 0.13091576269312669 0.28564981349522822 0.28998284028656435 -0.18832980806836891 -0.37426239001525713 -0.31495050044526779 0.12644089113037116 -0.038599835199010279 -0.14754440885452585 -0.38845993183642297 0.11967651027703351 -0.094286854118177166 -0.34783699957903386 -0.042513550669097427 0.18384247693312736 0.2047762592651933 -0.1531047769256651 0.033542746908956596 -0.10182202813382461 -0.2539337213643032 0.070635443558939998 0.047916523438670949 0.11873717799984222 0.21292271183707764 0.2818041292072172 0.17037273583457715 -0.28229675103509672 -0.016406696141582716 0.26617239386144287 -0.21104189117312866 0.049658439562814786 -0.22037047985361899 0.29387567753803101 0.33366468517939968 -0.046222677460251695 0.30756255874460614 0.092685977856244564 -0.089767608599986823 0.33089260914761132 0.3038742715288299 -0.083109805743104392 -0.17131570891797301 -0.04669705665248463 -0.18806632364914183 0.16357843787359252 0.048386285148282464 -0.1043947156150527;-0.19760873884182031 -0.096790755942111964 0.11188150061933319 0.2475531501550266 -0.59232172346251954 0.018576585333993596 -0.78693684447762213 -0.15586507113671558 -0.15157725855972123 -0.13043010044357409 0.0052124673363821089 0.031298010473112647 -0.19149678984334323 -0.29848990399936931 -0.55167659724629881 -0.27164243515265318 -0.15721330170061165 -0.053127242530989473 0.23966085564977935 -0.052712174652909706 -0.21316603402006171 -0.35367531945150926 -0.2525076679212615 -0.091277475283792042 0.47332306257852963 0.23699781490475455 0.69672707834487813 0.067027373414078079 0.056500302101252287 0.11035658743368186 0.27059628749354325 0.014677279139393543 0.30951069222399175 0.27525645369813734 -0.0022366007142295258 0.20241910688332612 0.45914438671437041 0.31776569736426036 0.44280374887173185 -0.13423546409439252 0.28781298288002333 0.51083986389216895 0.16286908704780975 0.0080550930352384434 0.095093390304021003 0.063396023470370155 0.26594372949571415 -0.064153433585788691 0.37602099949249845 -0.085606430931138289 -0.14360528528642261 -0.048833730906298799 -0.54059565214032745 -0.14752189496500709 0.13663047040678283 -0.29955918167728568 -0.51437383798917158;0.24419775120656836 -0.24953598668753654 0.28979432592227317 -0.034582049483143806 0.4579348541742731 0.20464578138407613 0.38091413628568094 0.076575590212824104 0.19112211048943523 -0.27142995661624303 -0.28128880597419881 0.15058873188104385 0.014988652253087613 0.17766892688877253 -0.20309122477878072 0.35490003580362389 -0.12872842180987842 -0.091280430137537824 -0.033616863262199044 -0.16249741175959975 0.071222541622129945 0.14519356512995416 0.36868141337097887 0.093876711013322275 -0.13652703399820287 0.079155318942566652 0.083755658461881349 0.072719282673170779 -0.31236013509679711 -0.37683145160138554 0.11016374343005605 -0.33525456196392101 -0.32768312364108876 -0.31769157319951802 -0.31382621754787954 0.031981723934244317 0.1474717531966416 -0.23252311928679389 -0.033492723219998327 -0.13030145949175964 -0.050164139846359056 -0.35637011337900271 0.053336086237209528 -0.027434292198628505 -0.0600292454727804 -0.34849341668507428 -0.1575721751795186 -0.15896790415209155 -0.010471360060065507 -0.1655610592987693 -0.086791213603989642 0.30974910294405333 0.42623162217461646 0.28703701151829614 0.23429306380165146 0.044443269686366825 0.3996262227782002;-0.34220973116260972 -0.19567507335559259 0.11179857750606931 0.27671177556717808 0.041124816133332465 0.50550628868117675 0.61157185727050167 0.039907955317948149 0.48923722143410697 0.25892493740857414 0.071543329562189367 -0.14440136946697618 0.034583674875884318 -0.21061263362329843 0.02219701554551826 0.54027347993670627 0.55899258109028938 0.41541093692604936 -0.13306955115874874 0.28984292218410834 -0.086189652796823973 0.21385898878452445 0.68747393136842483 -0.080892460133201255 -0.33373212472219593 -0.30452397404212295 -0.10091723947116008 -0.1614722490967942 -0.024330735070909798 -0.54362402300246748 -0.39147683335035222 -0.24859853208873287 -0.0049534601986602417 0.069827223425133519 -0.27281710519029545 -0.37957153968270246 -0.20062725703977222 -0.093892580857757146 -0.12628157458433226 -0.25367913440997775 -0.21649744178128044 -0.33799464088829795 -0.19624320304417123 -0.35669625096207846 -0.0075487118335632554 -0.53972752265552693 -0.17487241947727572 -0.064438121742833018 -0.19769870860278316 0.013959480798172294 0.20168963210942917 0.51225552041545075 0.082660083510763607 0.27182511284784427 -0.041638152553197409 -0.077090727772516951 0.20248795369404893;-0.29888501328759742 -0.1366972790143513 -0.20565721925590585 -0.32680235337853603 0.29433757759060675 0.36188795934278106 0.32706484394578555 0.29789754574146715 0.25764164591423422 0.12409542955309319 0.016243972988532578 0.19696344606485991 0.008517828415544295 -0.060204154172135246 0.18028646478324217 -0.20927033883739851 -0.021473178143987189 0.39387416841086703 0.14848643819028048 -0.10700141446259584 0.29870431379186418 -0.2075258883864832 -0.14710340675793088 -0.040927489730536747 -0.39996544953627855 0.065367656387060782 -0.47168447419270704 -0.076709091839620228 -0.29118936567643089 -0.17594817718919509 -0.033721932069310366 -0.21778702070535216 0.10709080741992437 0.31682291704144966 -0.055242082272456403 -0.12433617787809581 -0.41540753119514229 -0.038539125236524217 -0.19319369086777338 0.024884133358828643 0.10053263295388705 -0.19302609654073152 -0.068131833019513172 0.1157813498798797 0.0097501700210990538 0.010011618674851321 0.01219139575687433 -0.23605673113076583 0.27169446578324402 0.27549186865932623 -0.018817684566216571 0.23120370694531925 0.11202900923316104 0.092586254190155051 0.33041797284008856 -0.11860628874141643 -0.074301085395585872;0.33204575149834087 -0.062987252628730186 -0.16828778082982732 -0.118508437932921 -0.2101369688354488 -0.47208583382932345 -0.83207573969666448 -0.45324794259175816 0.02586303920760185 0.16347669668752121 -0.38015712383610867 0.078353226017533972 -0.14448457413742274 -0.055426973219809487 -0.11709785361337144 -0.52579086787834095 -0.55206666114059511 -0.2217350753790904 -0.085407181071794014 -0.16107575012166381 -0.10394313277348927 -0.06658173708033864 -0.5299533816960913 -0.26144907005652163 0.59928325032594021 0.43735220661364049 0.35045148326424602 0.17333561091497307 0.42326140246340355 0.45155270051827623 0.021954863725650687 0.11825305607376012 0.31777240874791501 -0.15941531942822082 0.39680200362855828 -0.13918749157875274 0.38705724069143727 0.27803992570915903 0.064281939196727048 0.27578946511345898 0.36094343063641116 0.54671525767137097 0.2131641731981018 -0.1376725991407341 0.50740827173896763 0.24527570750259686 -0.14974814753904653 0.43520579378405549 0.29831071289872901 -0.011375589108648946 0.33121621760067699 -0.1725317511939658 -0.44589164918743224 0.015973747934758156 -0.33406406763144475 0.21881973888962544 -0.57019386323253973;0.31984829588010349 -0.24483418298372381 -0.050010894075099184 -0.26871026163389178 -0.056149528812250757 -0.1899475337674674 0.41167372013845899 0.21492635735950441 0.16012207720902863 0.16122151003692081 -0.30940488084719631 0.18651126527943701 0.17021142934360523 0.064747909715313259 -0.031917954854989106 0.36001994368011025 0.26029816046341919 0.30076405578561105 -0.14942299485641228 0.027184834688686741 -0.091387024631400846 0.16222186570392622 0.33035043503722406 -0.23131346546027007 0.012097610208225619 -0.27712149793431684 -0.10674952703045652 -0.072950173191253104 -0.30175360816652796 0.12202332969011465 0.29546357982503879 -0.15951038301907131 0.24814563029969081 0.25325738037955936 -0.11855696300681268 -0.098996456943958117 -0.088591983197158525 0.36586975001690997 -0.26008098707483313 0.00022726672769982293 -0.092263409172336094 -0.15845040452628886 0.048895913576492978 -0.079538552543412411 0.31407813526319855 0.27472061480827098 0.25101523462929598 -0.027765213524150432 -0.12169001241282948 -0.11296459459826493 -0.085381769261126575 -0.18266053815858299 0.073774401127745443 -0.043851698760663631 -0.15687227112202889 -0.1502466194272728 0.074841626054888144;0.068747645047879849 0.20861738170510052 -0.15870960417205676 -0.075805189222376834 0.065409250406507233 -0.27313698181288559 0.37162451503712102 0.22776373966881533 -0.2165272178705529 -0.1285770793004517 -0.01146646284522209 -0.13141624799418192 -0.17154602796118879 -0.10223662317459241 0.071709763114314068 0.12286447225359473 0.15303779867735839 0.33434873223301081 0.35612734542036167 -0.085819320581533937 0.37096705359048771 0.11626189999024444 0.46259077939045568 0.25205209285466262 -0.23455342560051889 -0.063795571251201236 -0.42728692869801216 -0.13429125793217342 -0.43328500420060939 0.22039704904969223 -0.303372471514395 -0.17673957783685454 -0.0037279058567493916 -0.23038417182248067 0.039899589397141236 0.090428818088758856 0.012851621980234136 -0.11120266563507822 -0.13503452855586626 -0.03148595790008827 0.26555047819842031 0.081100205174957127 -0.085313632575970536 -0.091987404811108897 -0.258694985236333 -0.085233408457587548 -0.40927377738933862 0.040830556315153629 0.26984889843041215 -0.040534566469462789 0.23079375914317854 -0.2591745892138913 0.44658707242554774 0.020046004411004282 0.054242194960449838 0.26358648840440019 0.33993042686522762;0.03384643137764743 -0.12587793301064076 0.038282696095387155 -0.062809346974684752 0.0074503455508798961 0.056745587938342223 0.2151181835264924 -0.20319960825943198 -0.34949989983522056 0.17593972391637192 0.1815918104972607 -0.16017527949404756 -0.031058852587641943 -0.047225607604795432 -0.1072875199034818 -0.28586922947379945 -0.15566806585340726 -0.242642644396661 -0.035640778514766935 0.11948039166865389 0.16567621769197585 0.25023645972362984 -0.33861675773634825 -0.15131776336533476 -0.014376476213042893 -0.15124397191368524 0.34430587205741431 0.13726365692292336 0.18946455705103396 0.025324298843032642 -0.25048609273893474 -0.19495677915145429 0.32502077139883762 -0.29274044343581423 0.06757874126096311 0.26010206528666785 0.15565082565033034 -0.29231288041754616 0.073022138563964792 0.14933887214031116 -0.30329912247546481 -0.23223835352715155 -0.28842714702194655 0.32994066474754891 0.32388706614239782 -0.073783050623795185 0.065921233018509731 -0.29283818204266659 0.18776833321569428 0.034262857919324666 0.019439975180054459 0.058051829272317945 0.22711500378301469 0.1287064251771157 -0.022909087103532025 -0.035822380689457305 0.27219781761878148;-0.23248844983279354 0.17116130940819094 0.33419548430605694 0.044235042068736879 -0.0377702384173597 0.2332919196749286 -0.2987366298115966 0.17276191709417321 -0.21822169087509016 -0.28938893825920586 0.14905769961984644 0.0068428895853926931 0.13531591051554878 -0.23151774337529776 0.28189360569842092 -0.14881824100598237 -0.051666232682340198 -0.32636690881295366 0.28922877622729948 0.09184759205943259 -0.20121018415329836 -0.30303342498514657 0.04381490738227764 0.3478354555211019 0.033671285734855061 0.020887914406163298 -0.13565803521612499 -0.074843442331854595 -0.31174115693120247 0.092142175602121762 -0.065848937113105618 0.0074982886643783645 0.27983427917850251 0.031564633353799318 -0.043669521315167582 -0.29520061310144341 0.2680702015380661 0.27181524154186643 -0.1061155902407257 0.15281379251980712 -0.11635850204964612 0.102638748890578 0.23492233415865943 0.022735249665338759 0.012919628288205901 -0.087892260251294999 0.036632668587933043 -0.10384811443120273 -0.053935810285448769 0.34323466690317878 0.2865892325931052 0.16553822765832688 0.30592971237528577 0.16493974035026662 -0.28904655460751089 0.053854038432230723 -0.0043947010609226445;0.13335306967588786 0.32403825047696461 -0.15621647572881486 0.26207584850430687 -0.24369083645895553 0.07256824418039981 0.012633528126717116 0.27267044412585001 0.09985002492091026 -0.13340889119004143 -0.17368825902617888 -0.242907883658427 -0.19465585166359428 -0.18319142147829587 0.30551011709970355 0.12429424222875632 0.16762153074989536 -0.058547699767232092 -0.24253839398243798 -0.2482266866692826 0.11556508893397384 -0.1283457845789861 0.34124641796963395 -0.26785102673643524 0.11014235642615204 -0.21521706384133663 0.13240252179175238 -0.044773360334874071 0.25304208045448989 -0.10524556948053701 0.12398564344090443 0.12904047692103524 -0.29333062744726002 0.20026391417515255 0.22439879998833095 -0.24240585915684593 -0.044425127299133921 0.27486616257592783 -0.0012006417763691963 -0.2948241330991403 -0.13385266752315603 -0.089849802881988308 0.20621040497074075 0.093731086075160772 0.15473277460476953 0.023160587664404018 0.2763396874497005 -0.13677384149838656 0.21941109097865455 0.14357280496258604 -0.14562240004125487 0.31401538824805242 -0.219186184574756 0.10078951334474714 -0.30902187548377397 -0.20330950155720734 -0.0088669694399513121;-0.015684153079122517 0.1579819076290834 0.070348120957082483 -0.011889222243034564 0.058718054027436593 -0.15146742718247477 -0.2035836277297797 0.077592144303396962 0.15750603208400538 -0.13776986003254707 -0.091413310697208025 -0.15072516841777098 0.029365270801272086 -0.2977669302184266 -0.27876178248113231 0.088363788962728271 -0.18961371869022156 -0.15419270411989605 -0.15519469080136364 -0.33037760910897085 -0.40154778758383453 -0.016133320268925427 0.011711259031574864 -0.39081759132669747 0.23834325668848041 0.47149879560496832 0.15737816917740646 -0.14608352760379018 0.26719810049285686 -0.044225948943542773 0.22929878956927108 0.030483025893955414 0.2530804788837927 0.087747128099269198 -0.19604748375875589 0.090642526819859917 0.41318328163616952 -0.20823239947307015 0.022719944366269729 -0.024597702034833427 0.23191032136890583 0.4336332232464632 -0.22156095612647497 -0.022659743745721241 0.21606824162011165 -0.17923992535893646 -0.13120380500027576 -0.055235866867034501 -0.018757350881736849 0.23234674540520789 0.34913015582728912 0.013381510906945584 -0.45527376116296292 0.20136324190383925 -0.30658972580247662 -0.27202915344433037 0.15863771948826083];

% Layer 2
b2 = 0.03329523738070797;
LW2_1 = [-2.0919867153099663 -0.81337997908845028 0.91427292365233404 0.79049933123605109 0.70241208945945033 0.79690813764232626 -0.2501906656428261 -0.86129967184766854 -1.1643363818259551 -1.7908949341091773 1.0164861380249353 1.7878386115603373 0.71031449982667993 -2.089997658899664 0.37143937606060312 0.95949613195948635 -0.21706940141009201 0.21591174691410969 0.071050679230993549 -0.75046773476801343];

% ===== SIMULATION ========

% Format Input Arguments
isCellX = iscell(X);
if ~isCellX, X = {X}; end;

% Dimensions
TS = size(X,2); % timesteps
if ~isempty(X)
    Q = size(X{1},1); % samples/series
else
    Q = 0;
end

% Allocate Outputs
Y = cell(1,TS);

% Time loop
for ts=1:TS
    
    % Input 1
    X{1,ts} = X{1,ts}';
    Xp1 = mapminmax_apply(X{1,ts},x1_step1);
    
    % Layer 1
    a1 = tansig_apply(repmat(b1,1,Q) + IW1_1*Xp1);
    
    % Layer 2
    a2 = logsig_apply(repmat(b2,1,Q) + LW2_1*a1);
    
    % Output 1
    Y{1,ts} = a2;
    Y{1,ts} = Y{1,ts}';
end

% Final Delay States
Xf = cell(1,0);
Af = cell(2,0);

% Format Output Arguments
if ~isCellX, Y = cell2mat(Y); end
end

% ===== MODULE FUNCTIONS ========

% Map Minimum and Maximum Input Processing Function
function y = mapminmax_apply(x,settings)
y = bsxfun(@minus,x,settings.xoffset);
y = bsxfun(@times,y,settings.gain);
y = bsxfun(@plus,y,settings.ymin);
end

% Sigmoid Positive Transfer Function
function a = logsig_apply(n,~)
a = 1 ./ (1 + exp(-n));
end

% Sigmoid Symmetric Transfer Function
function a = tansig_apply(n,~)
a = 2 ./ (1 + exp(-2*n)) - 1;
end