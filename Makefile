.PHONY: install uninstall
.DEFAULT_GOAL := help

NAMESPACE := tomdewildt
NAME := gnome-gtklock-theme

THEME_NAME := gnome
THEME_DIR := ${HOME}/.config/gtklock/themes
THEME_CONFIG_DIR := ${HOME}/.config/gtklock
THEME_CONFIG_FILE := ${THEME_CONFIG_DIR}/config.ini

help: ## Show this help
	@echo "${NAMESPACE}/${NAME}"
	@echo
	@fgrep -h "##" ${MAKEFILE_LIST} | \
	fgrep -v fgrep | sed -e 's/## */##/' | column -t -s##

##

install: ## Install theme
	@echo "INFO: Copying '${THEME_NAME}' to '${THEME_DIR}'"
	@mkdir -p "${THEME_DIR}"
	@rm -rf "${THEME_DIR}/${THEME_NAME}"
	@cp -rf "./${THEME_NAME}" "${THEME_DIR}"

	@echo "INFO: Writing config to '${THEME_CONFIG_FILE}'"
	@mkdir -p "${THEME_CONFIG_DIR}"
	@{ \
		echo "[main]"; \
		echo "layout=${THEME_DIR}/${THEME_NAME}/layout.xml"; \
		echo "style=${THEME_DIR}/${THEME_NAME}/style.css"; \
		echo "time-format=%b %-d %H:%M"; \
	} > "${THEME_CONFIG_FILE}"

uninstall: ## Uninstall theme
	@echo "INFO: Removing '${THEME_NAME}' from '${THEME_DIR}'"
	@rm -rf "${THEME_DIR}/${THEME_NAME}"

	@echo "INFO: Removing config '${THEME_CONFIG_FILE}'"
	@if [ -f "${THEME_CONFIG_FILE}" ]; then \
		rm -f "${THEME_CONFIG_FILE}"; \
	fi
