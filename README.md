# 模板使用说明
- 中文支持使用的是xeCJK包。所以，**请使用XeLaTeX运行.tex文件**,由于要读取.aux辅助文件,**所以请运行两遍**，第一次运行结束后有提示信息。(注：因为模板里没有删除相应的辅助文件等，所以只要运行一遍即可！即相当于我已经给您运行了一遍了！)
## 参考文献
- 试题部分完全归功于exam文档类的作者. https://www.ctan.org/pkg/exam
  - 将exam文档类里的```\fullwidth```命令或者对应的```EnvFullwidth```环境封装成了新建了一个大题命令```\makepart```
  - 所以**试卷正文部分怎么输入，完全参考exam文档类里的格式，并结合```LaTeX```语法**。
    - 具体使用方法请查看exam文档类，Windows下运行命令```texdoc exam```，或者查阅上面的ctan，或者网上的中英文资料，**如：https://blog.csdn.net/xovee/article/details/90599346**
    - 答案的显示方式可以参考上面的方法，在含答案的版本，导言里有设置一些参数。
- 评分标准部分参考自jnuexam. https://ctan.org/pkg/jnuexam
- 左边表格学生信息部分参考自我问的问题（别人给出的解答）： https://tex.stackexchange.com/questions/492568/how-could-i-print-the-table-on-the-left-of-the-page
- (2019/10/7) 将抬头的**表格自动生成**，采用`LaTeX3`方式。主要借鉴于下面链接的实现方式
  - https://tex.stackexchange.com/questions/495534/custom-points-table-for-exam/495723#495723
## 模板情况说明
- 提供连续题序标号和不连续题序标号两种模板(连续题序类似高考题的题序标号)(其中not countinous labeled.tex文件为非连续编号的).
- 16开的纸张，具体是长270mm,宽195mm的16开纸。两张16开的纸合成一张大的8开的纸。双栏单面，分左右页边距。
- 对抬头的字号，大题的字号，正文的字号，都使用的是pt表示出来，根据其它地方的说明，和标准的尺寸有一点点偏差，有兴趣的可以查阅资料看看。
- 模板来源于教务处word版模板。http://jwc.hynu.cn/info/1087/4209.htm
## 更新说明
 - (2019/10/18) 将\makepart{}[]{}命令写成了可选参数形式
 - (2019/12/14）将试卷前面的信息有些字体加粗了,判断题设置为括号且放置在最前面。添加了一些注释，删除了一些以前版本的代码~
 - (2019/12/19) 将不连续题序标号为新的一个文件，可按照需要选择不同的文件模拟来出题。
## 已知小问题或还没有做到的地方：
- 该文档主要是使用的目的，由于主要工作是exam文档类作者完成的，所以没有使用LaTeX宏包或文档类的标准书写完成。只有一个.cls文件。
- ~~将exam文档类中选择题的参考答案改为不加粗，而是用ABCD写在括号内。但因为是参考答案，主要是给出答案，所以个人认为并不关键。~~
- （已解决）~~将判断题答案填写处放置一个括号，而不是划一个横线。~~
- （已改进）~~需要手动调节开始处表格里几个大题，分值为多少（我尝试过如果自动，编译时间太慢（还要编译两遍），不如手动改一改，或者是我用的方法不太好，需改进）。~~
- （待改进？）根据exam文档类，留空白作答，可能需要根据题目的长度来手动调节在哪里分页。
- （待改进）因为左边学生表格信息当成页边距，所以页码看上去不是居中的。
- （待改进）如果选择题ABCD四个选项太长，可以手动在B答案后面加入\\\进行换行，希望未来可以像其它模板一样实现自动判断是分四行、分两行还是一行输出选择题的选项。这样子弄出来的两行，B答案和D答案可能并不对齐，要么不考虑对齐，要么加入空格（如\hspace*{2em}）来对齐。
- exam文档类没有使用多文档形式，没有使用试题库
- 没有实现怎么将首页的页边距设置与其它页的页边距不同。geometry宏包我没有找到很好的解决方法，可能有部分我没有读懂。（exam文档类自带了边距控制命令）。
- ~~出现同一个大题的不同小题如果分值不同的情况时，大题命令还没有做完。~~
- 一个大题包含多少个小题本身可以自身计算出来，一是我偷懒了，二是为了提醒自己将总分核对完整。(现在总分是自动计算的)

### 其它
- exam文档类最后更新是2017年，但事实上，作者的个人主页上有2019年暑假的beta版。http://www-math.mit.edu/~psh/exam/betatest/exam.cls

#### Note
- The .cls file is for Hengyang Normal University exam template.
- .tex files are some examples.
- It is based on exam and jnuexam template on ctan: https://www.ctan.org/pkg/exam and https://ctan.org/pkg/jnuexam
- different types of questions continuous labeling
- student information table on the left of the first page. The table which I don't know how to deal with is drawed by a question that I ask in stackexchange. https://tex.stackexchange.com/questions/492568/how-could-i-print-the-table-on-the-left-of-the-page
---
