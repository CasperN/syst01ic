
info:
	@echo "make clean \t remove *.o"
	@echo "make element \t test systolic array element"
	@echo "make matmul \t test systolic array matrix multiply"

clean:
	rm *.o

element:
	iverilog -o test_element.o test_element.v
	./test_element.o

matmul:
	iverilog -o test_matmul.o test_matmul.v
	./test_matmul.o
