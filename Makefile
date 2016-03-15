.PHONY: updateDependencies


# default
all: updateDependencies

#
# Tasks
#
updateDependencies:
	carthage update --platform iOS
