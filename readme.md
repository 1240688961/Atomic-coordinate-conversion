这是我研一的时候，用Shell写的一个脚本，   
可以将分数坐标变成直角坐标   
似乎没什么用处   
需要POSCAR文件，  
算完后会输出newposcar.vasp  
由于bash本身的原因，  
速度有点慢。  
使用方法： 在文件夹中同时有POSCAR 和本result.sh  
执行  
```
./result.sh
```
如果报错，请删除脚本的第一行  dos2unix POSCAR   
dos2unix命令用来将DOS格式的文本文件转换成UNIX格式的（DOS/MAC to UNIX text file format converter）。   
DOS下的文本文件是以\r\n作为断行标志的，表示成十六进制就是0D 0A。而Unix下的文本文件是以\n作为断行标志的，表示成十六进制就是0A。  
  DOS格式的文本文件在Linux底下，用较低版本的vi打开时行尾会显示^M，而且很多命令都无法很好的处理这种格式的文件  
各个平台使用的文本编码规范不同，导致了同一文本在不同平台中显示不同
