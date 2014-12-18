require_relative 'shop'

origin ="1  Japanese  21754
2 Korean  7310
3 Soups 186
4 Indian  3304
5 Pakistani 188
6 Caribbean 176
7 French  7089
8 Mexican 1386
9 Italian 9697
10  Bar 7150
11  Dessert 4011
12  Winery  96
13  Coffee Shop 4630
14  Café  5626
15  Hamburgers  1358
16  Bistro  937
17  Chinese 7936
18  Sushi 2859
19  Asian 2136
20  American  5180
21  African 261
22  Vegetarian  1760
23  Australian  249
24  European  2069
25  Pizza 1939
26  Tapas 1018
27  Pizza & Pasta 1064
28  Fast Food 1556
29  Vietnamese  1039
30  Israeli 52
31  Contemporary  921
32  Thai  4323
33  Diner 567
34  Wine Bar  810
35  Seafood 4312
36  Scandinavian  68
37  Middle Eastern  480
38  Moroccan  259
39  Halal 151
40  Delicatessen  743
41  Bagels  187
42  Family Fare 203
43  Indonesian  3025
44  Pan-Asian 82
45  Cajun & Creole  68
46  Ice Cream 1055
47  Bakery  2179
48  Chicken Wings 1313
49  Gastropub 405
50  Swiss 69
51  Fondue  51
52  Asian fusion  1594
53  Argentinean 247
54  Spanish 2030
55  Brew Pub  313
56  International 3386
57  Noodle  6702
58  Barbecue  1740
59  Mediterranean 2204
60  Brazilian 182
61  Kosher  160
62  Healthy 582
63  Sandwiches  985
64  Puerto Rican  3
65  Irish 226
66  Persian 175
67  Armenian  30
68  Dim Sum 1170
69  Vegan 358
70  Steakhouse  1420
71  Tea Room  600
72  Pub 1008
73  Fusion  1190
74  Belgian 191
75  Egyptian  37
76  British 1728
77  Grill 1808
78  Latin 183
79  Turkish 571
80  Cuban 93
81  Malaysian 395
82  Basque  76
83  Hot Dogs  93
84  Hawaiian  45
85  Organic 268
86  Greek 1139
87  Dutch 354
88  Portuguese  225
89  Canadian  22
90  Taiwanese 3324
91  Brasserie 408
92  Lebanese  429
93  Southwestern  83
94  English 950
95  Oyster Bar  76
96  Continental 1299
97  Austrian  58
98  Creperie  162
99  Cambodian 37
100 Russian 151
101 Peruvian  83
102 Eclectic  382
103 Scottish  15
104 Ethiopian 63
105 Noodle Shop 2645
106 Czech 8
107 NorthWestern Chinese  30
108 Polynesian  12
109 South American  132
110 Eastern European  83
111 German  498
112 Californian 187
113 Hungarian 16
114 Fish & Chips  168
115 Yugoslavian 9
116 Shanghai  352
117 Jamaican  35
118 Hunan 24
119 Philippine  36
120 Filipino  52
121 Colombian 37
122 Ukrainian 15
123 Pacific Rim 44
124 Ecuadorean  7
125 Danish  24
126 Central European  92
127 Pasta 413
128 Tibetan 31
129 Polish  47
130 Native American 12
131 Afghan  35
132 Anhui 2
133 Cantonese 144
134 Central American  47
135 Chilean 14
136 Swedish 36
137 Burmese 17
138 Venezuelan  18
139 New Zealand 21
140 Afghani 26
141 Donuts  167
142 Zhejiang  4
143 cuisine.name.191  102
144 Szechuan  209
145 Singaporean 172
146 Hong Kong 60
147 Nepali  205
148 Salvadoran  10
149 Sri Lankan  28
150 Tunisian  37
151 Norwegian 9
152 Chinese Hotpot  63
153 Chowder 31
154 Bangladeshi 63
155 Romanian  15
156 Yunnan  5
157 Hubei 1
158 Nonya 48
159 NorthEastern Chinese  14
160 Mongolian 32
161 Albanian  8
162 Beijing Specialties 10
163 Minority Chinese  14
164 Balti 4
165 Croatian  6
166 Xinjiang  3
167 Bahamian  6
168 Hangzhou  1
169 Imperial Chinese  16
170 Shandong  2
171 Latvian 1
172 Fujian  1
173 Jiangxi 1
174 Guatemalan  8".lines

ch ="日本
韩国
汤类
印度
巴基斯坦
加勒比
法国
墨西哥
意大利
新式酒吧
甜品
酒厂
咖啡厅
咖啡厅
汉堡
小酒馆
中国
寿司
亚洲
美国
非洲
素食
澳大利亚
欧洲
比萨
小吃
比萨和意大利面
快餐
越南
以色列
当代
泰国
晚餐
酒吧
海鲜
斯堪的纳维亚
中东
摩洛哥
清真
熟食店
面包圈
家庭套餐
印尼
泛亚
印第安＆克里奥耳
冰淇淋
面包店
鸡翅
美食酒吧
瑞士
火锅
亚洲混合
阿根廷
西班牙
酿造酒吧
国际
面
烧烤
地中海
巴西
犹太
健康
三明治
波多黎各
爱尔兰
波斯
亚美尼亚
点心
纯素
牛排餐厅
茶室
老式酒吧
融合
比利时
埃及
英国
烧烤
拉丁
土耳其
古巴
马来西亚
巴斯克
热狗
夏威夷
有机食物
希腊
荷兰
葡萄牙
加拿大
台湾
小酒馆
黎巴嫩
西南
英语
生蚝吧
大陆
奥
可丽饼
柬埔寨
俄罗斯
秘鲁
折衷主义
苏格兰
埃塞俄比亚
面店
捷克
中国西北
波利尼西亚
南美
东欧
德国
加州
匈牙利
炸鱼薯条
南斯拉夫
上海
牙买加
湖南
菲律宾
菲律宾
哥伦比亚
乌克兰
环太平洋
厄瓜多尔
丹麦
中欧
面食
西藏
波兰
美国本土
阿富汗
安徽
广州
中美洲
智利
瑞典
缅甸
委内瑞拉
新西兰
阿富汗尼
甜甜圈
浙江
法国
四川
新加坡
香港
尼泊尔
萨尔瓦多
斯里兰卡
突尼斯
挪威
中国火锅
杂烩
孟加拉国
罗马尼亚
云南
湖北
娘惹（中国马来西亚新加坡）
中国东北
蒙古
阿尔巴尼亚
北京特产
中国少数民族
巴蒂
克罗地亚
新疆
巴哈马
杭州
中国宫廷菜
山东
拉脱维亚
福建
江西
危地马拉".lines

# origin.each_with_index do |o, i|
#   begin
#   number = (i + 1).to_s
#   SimpleCataMap.create(id: (i * 10 + 1), ta_cata: ch[i][number.length..-1].strip, cuisine_id: number)
# rescue => e
#   byebug
# end  
# end  


# ch.each_with_index do |o, i|
#   # begin
#     c = Cuisine.find(i + 1)
#     c.chinesename = o.strip
#     c.save
#   # rescue => e
#   #   byebug
#   # end  
# end 

byebug

1



