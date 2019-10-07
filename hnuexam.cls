\NeedsTeXFormat{LaTeX2e}
%The command \NeedsTeXFormat{LaTeX2e} sets the LATEX version for the class to work. Additionally, a date can be added within brackets to specify the minimal release date required.
\ProvidesClass{hnuexam}[2019/06/15 Example LaTeX class]
%2019/05/27 version 1.1
%2019/06/15 version 1.2
%2019/09/29 version 1.3
%2019/10/7  version 2.0
%The command ProvidesClass{exampleclass}[...] identifies this class as exampleclass and, inside the brackets, the release date and some additional information is included. The date should be in the form YYYY/MM/DD

\LoadClass{exam}
\RequirePackage{amsmath,amssymb,amsthm}	%美国数学学会系列
\RequirePackage{tikz}	%tikz用于画图包
\RequirePackage{xeCJK,zhnumber} %支持中文，中文数字包
\RequirePackage{geometry}	%设置页边距等
\RequirePackage{indentfirst}	%设置首段缩进
\RequirePackage{xhfill,xcolor}	%评分标准右对齐，颜色包
\RequirePackage{etoolbox,expl3,xparse,xinttools,xfp,totcount}%LaTeX3及其它包
\RequirePackage{multirow,tabu,diagbox} %表格包，表格多行合并包
\RequirePackage{bbding}	%对错符号包
%\RequirePackage is very similar to the well-known \usepackage

\DeclareOption{answer}{\printanswers}
\DeclareOption{addtable}{\addpoints}
%The command \DeclareOption{}{} handles a given option. It takes two parameters, the first one is the name of the option and the second one is the code to execute if the option is passed.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
%\PassOptionsToClass{}{}. Passes the option inside the first pair of braces to the document class set inside the second pair of braces. 

\ProcessOptions\relax
%The command \ProcessOptions\relax executes the code fore each option and must be inserted after all the option-handling commands were typed. There's a starred version of this command that will execute the options in the exact order specified by the calling commands.

% 中英文字体设置
\newCJKfontfamily[song]\songti{SimSun}
\newCJKfontfamily[hei]\heiti{SimHei}
\setmainfont{Times New Roman}
\setsansfont{Arial}
% 定义默认字体大小和行距
\renewcommand{\normalsize}{\fontsize{12pt}{\baselineskip}\selectfont}

% 试卷纸张设置，16开的纸（两页合成一个大页的方式）
\geometry{paperheight=270mm,paperwidth=195mm} 
% 设置试卷的页眉页脚与页边距的距离
\geometry{vmargin={1.5cm,2cm},footskip=0.5cm,marginparsep=0cm}
\geometry{inner=3cm,outer=1cm}

% 设置首行缩进
\setlength{\parindent}{0em}

% 设置表格放缩
\renewcommand\arraystretch{1.5}

% 打印右边学生信息命令
\newcommand{\databox}{%
  \smash{\makebox[0pt][r]{%
  	\fontsize{10.5pt}{15.75pt}\selectfont
    \begin{tabular}[t]{|p{2cm}<{\centering}|}
    \multicolumn{1}{c}{} \\[2in] % lower the box
    \hline
    学\hfil 院\\
    \hline
    \\[2\normalbaselineskip]
    \hline
    专\hfil 业\\
    \hline
    \\[2\normalbaselineskip]
    \hline
    班\hfil 级\\
    \hline
    \\[2\normalbaselineskip]
    \hline
    学\hfil 号\\
    \hline
    \\[2\normalbaselineskip]
    \hline
    姓\hfil 名\\
    \hline
    \\[2\normalbaselineskip]
    \hline
    \end{tabular}\hspace{0.5em} 
    \normalsize
  }}%
  \gdef\databox{}%
}

% 衡阳师范学院抬头
\newcommand{\examinformation}[5]{%
	\begin{center}%
		{\fontsize{18pt}{2\baselineskip}\selectfont\heiti\bfseries #1\\
			#2\\
			#3\\
			\ifprintanswers
				参考答案及评分标准\\
			\fi
			\vspace{0.2em}			
		}{\fontsize{10.5pt}{2\baselineskip}\selectfont\songti
		考核类型:~#4\hspace{1cm}考试时量：#5~分钟%
		}
	\end{center}
}

% 定义大题、总分计数器并初始化为0
\newtotcounter{examSection}
\newtotcounter{sumpoints}

% LaTeX3 语法
\ExplSyntaxOn
\clist_new:N \g_grades_clist
\clist_new:N \g_grades_aux_clist
% 开始一个大题的命令
\NewDocumentCommand{\makepart}{ m m m }{
   	\stepcounter{examSection}
	\addtocounter{sumpoints}{#3}
	 % store both the  score in \g_grades_clist
	\__add_to_grades_list:n  { #3 }
	\begin{EnvFullwidth}
		\vspace{0.05em}%
		\fontsize{14pt}{16.8pt}\selectfont
		\begin{tabular}{|c|c|c}
			\cline{1-2}
			得分 & 评阅人 & \multirow{2}{*}{\zhnum{examSection}、#1(每小题~#2~分，共~#3~分)} \\
			\cline{1-2}
			& & \\
			\cline{1-2}
		\end{tabular}
		\normalsize
		\vspace{0.5em}
	\end{EnvFullwidth}
}
% add score to \g_grades_clist
\cs_new:Nn \__add_to_grades_list:n {
  \clist_gput_right:Nx \g_grades_clist { #1 }
}
% 按题型打印表格
\NewDocumentCommand{\sectiongradetable}{}{
    \if@addpoints
        \@ifundefined{exam@numpoints}{%
                \ClassWarning{exam}{%
                    You must run LaTeX again to produce the table.\MessageBreak
                }%
                \fbox{Please Run \LaTeX{} again to produce the table}%
             }%
            {\constructionTable}%
    \else
        \ClassError{exam}{%
              You must give the command \protect\addpoints\MessageBreak
              \space\space in order to create a grade table.\MessageBreak
          }{%
              If you don't give the command \protect\addpoints\MessageBreak
              \space\space then we're not keeping track of point values.
              \MessageBreak
          }%
  \fi
}

% set grade list from the aux file
\NewDocumentCommand\SetGradeList{m}{
	\clist_gset:Nn \g_grades_aux_clist {#1}
}

% 写入辅助文件
\AtEndDocument{
  \iow_now:cx { @auxout } {
    \token_to_str:N \SetGradeList { \g_grades_clist  } ^^J
  }
}

% 实际输出表格的命令，使用xinittools包来循环
\NewDocumentCommand{\constructionTable}{}{
	\fontsize{10.5pt}{1.5\baselineskip}\selectfont
	\begin{table}[h]
		\centering
		\begin{tabular}{|*{\inteval{4+\totvalue{examSection}}}{c|}}
			\hline
			题号 \xintFor* ##1 in {\xintSeq {1}{\totvalue{examSection}}} \do {&\zhnumber{##1}} & 总分 & 合分人 & 复查人\\
			\hline
			总分 \xintFor ##1 in  \g_grades_aux_clist \do {& ##1} & \total{sumpoints} & \multirow{2}{*}{} & \multirow{2}{*}{} \\
			\cline{1-\inteval{2+\totvalue{examSection}}}
			得分  \xintFor* ##1 in {\xintSeq {1}{\inteval{1+\totvalue{examSection}}}} \do{&} &  &\\
			\hline
		\end{tabular}
	\end{table}
	\normalsize		
}
\ExplSyntaxOff

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 一个实际的表格的样子
% \begin{tabular}{|c|c|c|c|c|c|c|c|}
% 	\hline
% 	题号 & 一 & 二 & 三 & 四 & 总分 & 合分人            & 复查人            \\
% 	\hline
% 	总分 & 15 & 15 & 10 & 60 & 100  & \multirow{2}{*}{} & \multirow{2}{*}{} \\
% 	\cline{1-6}
% 	得分 &    &    &    &    &      &                   &                   \\
% 	\hline
% \end{tabular}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 开始一个大题的命令，每个小题分数不一定相同（beta测试命令）
\newcommand{\makepartnoteq}[3]{
	\stepcounter{dati}
	\vspace{0.5em}%
	\noindent\begin{tabular}{|c|c|c}
		\cline{1-2}
		得分 & 评阅人 & \multirow{2}{*}{\zhnum{dati}、#1({共~#2~小题，共#3分})} \\
		\cline{1-2}
		& & \\
		\cline{1-2}
	\end{tabular}
	\vspace{1em}
}

% 表，分，页等中文个性化输出
\renewcommand{\tablename}{表}
\pointname{分}
\renewcommand{\thepartno}{\Roman{partno}}
\cfoot{第\thepage~页~,~共\numpages~页}
\renewcommand{\solutiontitle}{\noindent\textbf{解:}\noindent}

% 评分标准，按是不是数学环境输出
\newrobustcmd{\score}[1]{%
  \ifbool{mmode}{%
    \ifdefstrequal{\tag}{\dft@tag}{\scoreeqno{#1}}{\scoretag{#1}}%
  }{%
  	\scoretext{#1}
  }%
}
% 非数学环境使用此输出评分标准
\newcommand{\scoretext}[1]{\xdotfill{1pt}[blue]\myscore{#1}\par\noindent\ignorespaces}
% 数学环境使用此输出评分标准
\newcommand{\scoreeqno}[1]{\eqno{\cdotfill\text{\myscore{#1}}}}
\newcommand{\scoretag}[1]{\tag*{$\cdots\cdots$\myscore{#1}}}

\newcommand{\myscore}[1]{\textcolor{blue}{#1\kern0.2em \text{分}}}

% 判断题的答案输出
\newcommand{\tf}[1][{}]{%
\fillin[#1][0.25in]%
}
% 大题的小问的标号以罗马字母标号
\renewcommand{\thepartno}{\Roman{partno}}

% 输出左边学生需要填写信息的表格
\lhead{\databox}

% 定义输出大小写罗马数字的命令
\newcommand{\rmnum}[1]{\romannumeral #1}
\newcommand{\Rmnum}[1]{\expandafter\@slowromancap\romannumeral #1@}
