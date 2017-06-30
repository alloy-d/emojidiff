TARGET=.
MACHINES_FILE=$(TARGET)/list.txt
HUMANS_FILE=$(TARGET)/list.md

all: for-machines for-humans

for-machines:
	./fetch.sh > $(MACHINES_FILE)

for-humans: $(MACHINES_FILES)
	./generate-table.awk < $(MACHINES_FILE) > $(HUMANS_FILE)

.PHONY: all for-machines
