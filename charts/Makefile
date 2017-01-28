CHARTS := $(shell find . -path '*/Chart.yaml' | tr '\n' ' ' | sed -E 's:\./|/Chart\.yaml::g')
DEP_CHARTS := $(shell find . -path '*/requirements.yaml' | tr '\n' ' ' |  sed -E 's:\./|/requirements\.yaml::g')

.PHONY: clean all package makepath copy index sync acl dependency-update
all: package makepath copy index sync clean

dependency-update:
	helm init -c
	helm repo add zonar-charts http://charts.zonar.cnct.io
	$(foreach chart,$(DEP_CHARTS),(helm dependency update --debug $(chart); echo $?) && ) :

lint:
	$(foreach chart,$(CHARTS),(helm lint $(chart)) &&) :

package: dependency-update ; $(foreach chart,$(CHARTS),(helm package $(chart) --save=false) &&) :

makepath:
	@mkdir -p .zonar-charts

copy:
	@mv *.tgz .zonar-charts/

index:
	@gsutil -h Cache-Control:private -m cp gs://charts.zonar.cnct.io/index.yaml .zonar-charts/index.yaml
	@helm repo index .zonar-charts --url http://charts.zonar.cnct.io --merge .zonar-charts/index.yaml

sync:
	@gsutil -h Cache-Control:private -m cp -r .zonar-charts/* gs://charts.zonar.cnct.io
	
clean:
	@rm -rf .zonar-charts