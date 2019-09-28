# Note
- The .cls file is for Hengyang Normal University exam template.
- .tex files are some examples.
- It is based on exam and jnuexam template on ctan: https://www.ctan.org/pkg/exam and https://ctan.org/pkg/jnuexam
- different types of questions continuous labeling
- student information table on the left of the first page. The table which I don't know how to deal with is drawed by a question that I ask in stackexchange. https://tex.stackexchange.com/questions/492568/how-could-i-print-the-table-on-the-left-of-the-page
---
## 模板说明
- 试题部分完全支持exam文档类. https://www.ctan.org/pkg/exam
- 评分标准部分参考自jnuexam. https://ctan.org/pkg/jnuexam
- 左边表格学生信息部分参考自我问的问题（别人给出的解答）： https://tex.stackexchange.com/questions/492568/how-could-i-print-the-table-on-the-left-of-the-page
- 采用连续题序标号(类似高考题的题序标号)
- 16开的纸张，具体是长270mm,宽195mm的16开纸。
- 两张16开的纸合成一张大的8开的纸。双栏单面，分左右页边距。
- 使用xeLaTeX运行一遍.tex文件。
- 模板来源于word版文件

### 已知小问题或还没有做到的地方：
- 将exam文档类中选择题的参考答案改为不加粗，而是用ABCD写在括号类。但因为是参考答案，主要是给出答案，所以个人认为并不关键。
- 将判断题答案填写处放置一个括号，而不是划一个横线。
- （待改进？）需要手动调节开始处表格里几个大题，分值为多少（我尝试过如果自动，编译时间太慢（还要编译两遍），不如手动改一改，或者是我用的方法不太好，需改进）。
- （待改进？）根据exam文档类，留空白作答，可能需要根据题目的长度来手动调节在哪里分页。
- （待改进）因为左边学生表格信息当成页边距，所以页码看上去不是居中的。
- （待改进）如果选择题ABCD四个选项太长，可以手动在B答案后面加入\\\进行换行，希望未来可以像其它模板一样实现自动判断是分四行、分两行还是一行输出选择题的选项。这样子弄出来的两行，B答案和D答案可能并不对齐，要么不考虑对齐，要么加入空格（如\hspace*{2em}）来对齐。
- 在调试的时候为了方便将边距、页眉页脚的长度设置放在了正文里。
- 并没有使用多文档形式。
- 没有使用试题库
- 没有实现怎么将首页的页边距设置与其它页的页边距不同。geometry宏包我没有找到很好的解决方法，可能有部分我没有读懂。
- 出现同一个大题的不同小题如果分值不同的情况时，大题命令还没有做完。
- 一个大题包含多少个小题本身可以自身计算出来，一是我偷懒了，二是为了提醒自己将总分核对完整。
