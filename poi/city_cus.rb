require_relative 'shop'
citys = %w{2332
  343
}

# citys.each do |city|
#   ShopsCuisine.where(shop_id: Shop.where(city_id: city).pluck(:shop_id)).pluck(:cuisine_id).uniq.each do |cu|
#     CitysCuisine.create(city_id: city, cuisine_id: cu)
#   end  
# end  

# debugger

# 

cuisines = %w{
32
17
72
20
9
25
58
35
40
70
102
95
27
15
18
19
1
3
59
8
73
86
22
93
16
77
28
63
69
29
111
62
42
10
153
47
88
54
26
7
13
33
121
65
112
31
11
110
56
45
37
128
4
2
78
131
68
60
76
74
61
30
21
53
6
14
98
5
81
104
49
96
79
109
34
48
92
71
114
46
127
24
123
126
83
55
80
135
51
41
85
130
94
103
106
67
23
52
105
38
99
118
84
66
50
129
97
12
101
120
119
137
100
44
147
141
144
133
117
113
89
57
160
161
43
39
107
75
134
108
146
90
125
82
64
91
172
87
165
154
36
152
164
148
136
151
140
167
174
169
116
122
115
150
139
124
138
177
145
143
163
155
149
170
158
159
132
176
175
162
}
cuisines.each do |cu|
 CitysCuisine.create(city_id: '2332', cuisine_id: cu)
end
