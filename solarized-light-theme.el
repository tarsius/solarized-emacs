;;; solarized-light-theme.el --- Light Solarized theme  -*- lexical-binding:t -*-

;; Copyright (C) 2011-2019 Bozhidar Batsov
;; Copyright (C) 2012-2019 Thomas Frössman
;; Copyright (C) 2014-2024 Jonas Bernoulli

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; The light variant of the Solarized theme.

;;; Code:

(require 'solarized-themes)

(deftheme solarized-light "The light variant of the Solarized colour theme")

(create-solarized-theme 'light 'solarized-light)

(provide-theme 'solarized-light)

(provide 'solarized-light-theme)
;;; solarized-light-theme.el ends here
