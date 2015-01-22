clean:
	rm ./data/html/*

download:
	curl "http://mos.memo.ru/shot-[1-78].htm" -o "data/html/#1.htm"

encode:
	find ./data/html/ -name "*.htm" -type f -exec sh -c 'echo {} && iconv -f windows-1251 -t utf-8 < {} > {}l' \;
	rm ./data/html/*.htm
	for n in $(seq 9); do mv ./data/html/$n.html data/html/0$n.html; done;

json:
	mkdir -p data/json/
	for f in data/html/*.html; do echo $$f && pup -f $$f "table td:nth-child(2) json{}" --charset utf-8 > $$f.json; done
	mv data/html/*.json data/json/
	for i in data/json/*.json ; do echo "$${i/.html.json/.json}" && mv "$$i" "$${i/.html.json/.json}" ; done

data: clean download encode json
