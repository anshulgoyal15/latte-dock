/*
*  Copyright 2016  Smith AR <audoban@openmailbox.org>
*                  Michail Vourlakos <mvourlakos@gmail.com>
*
*  This file is part of Latte-Dock
*
*  Latte-Dock is free software; you can redistribute it and/or
*  modify it under the terms of the GNU General Public License as
*  published by the Free Software Foundation; either version 2 of
*  the License, or (at your option) any later version.
*
*  Latte-Dock is distributed in the hope that it will be useful,
*  but WITHOUT ANY WARRANTY; without even the implied warranty of
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*  GNU General Public License for more details.
*
*  You should have received a copy of the GNU General Public License
*  along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/
import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.plasmoid 2.0

import org.kde.latte 0.2 as Latte

PlasmaComponents.Page {
    Layout.maximumWidth: content.width + content.Layout.leftMargin * 2
    Layout.maximumHeight: content.height + units.smallSpacing * 2

    ColumnLayout {
        id: content

        width: (dialog.appliedWidth - units.smallSpacing * 2) - Layout.leftMargin * 2
        spacing: dialog.subGroupSpacing
        anchors.horizontalCenter: parent.horizontalCenter
        Layout.leftMargin: units.smallSpacing * 2
        Layout.rightMargin: units.smallSpacing * 2

        //! BEGIN: Appearance
        ColumnLayout {
            spacing: units.smallSpacing
            Layout.rightMargin: units.smallSpacing * 2
            Layout.topMargin: units.smallSpacing

            Header {
                text: i18n("Appearance")
            }

            PlasmaComponents.CheckBox {
                id: blurPanel
                Layout.leftMargin: units.smallSpacing * 2
                text: i18n("Blur for panel background")
                checked: plasmoid.configuration.blurEnabled

                onClicked: {
                    plasmoid.configuration.blurEnabled = checked
                }
            }

            PlasmaComponents.CheckBox {
                id: titleTooltipsChk
                Layout.leftMargin: units.smallSpacing * 2
                text: i18n("Show applets/task title tooltips on hovering")
                checked: plasmoid.configuration.titleTooltips

                onClicked: {
                    plasmoid.configuration.titleTooltips = checked;
                }
            }

            PlasmaComponents.CheckBox {
                id: shrinkThickness
                Layout.leftMargin: units.smallSpacing * 2
                text: i18n("Shrink thickness margins to minimum")
                checked: plasmoid.configuration.shrinkThickMargins

                onClicked: {
                    plasmoid.configuration.shrinkThickMargins = checked
                }
            }
        }
        //! END: Appearance

        //! BEGIN: Dynamic Background
        ColumnLayout {
            spacing: units.smallSpacing
            Layout.rightMargin: units.smallSpacing * 2
            enabled: Latte.WindowSystem.compositingActive

            Header {
                text: i18n("Dynamic Background")
            }

            PlasmaComponents.CheckBox {
                id: solidForMaximizedChk
                Layout.leftMargin: units.smallSpacing * 2
                Layout.maximumWidth: (dialog.appliedWidth - units.smallSpacing * 2) - 3*units.smallSpacing
                text: i18n("Force solid background for maximized or snapped windows")
                checked: plasmoid.configuration.solidBackgroundForMaximized
                tooltip: i18n("The panel background removes its transparency setting \n when there is a maximized or snapped window")
                style: LatteCheckBoxStyle{}

                onClicked: {
                    plasmoid.configuration.solidBackgroundForMaximized = checked;
                }
            }

            PlasmaComponents.CheckBox {
                id: onlyOnMaximizedChk
                Layout.leftMargin: units.smallSpacing * 2
                text: i18n("Hide background for not maximized windows")
                checked: plasmoid.configuration.backgroundOnlyOnMaximized
                tooltip: i18n("The panel background becomes transparent except if \nthere is a maximized or snapped window")

                onClicked: {
                    plasmoid.configuration.backgroundOnlyOnMaximized = checked;
                }
            }

            PlasmaComponents.CheckBox {
                id: colorizeTransparentPanelsChk
                Layout.leftMargin: units.smallSpacing * 2
                Layout.maximumWidth: (dialog.appliedWidth - units.smallSpacing * 2) - units.smallSpacing * 3
                text: i18n("Monochrome contents when panel is transparent")
                checked: plasmoid.configuration.colorizeTransparentPanels
                tooltip: i18n("The panel contents are colorized in order to improve contrast \nwith the underlying desktop background when the panel is transparent")
                style: LatteCheckBoxStyle{}

                enabled: solidForMaximizedChk.checked || onlyOnMaximizedChk.checked

                onClicked: {
                    plasmoid.configuration.colorizeTransparentPanels = checked;
                }
            }

            PlasmaComponents.CheckBox {
                id: colorizeFromActiveWindowSchemeChk
                Layout.leftMargin: units.smallSpacing * 2
                Layout.maximumWidth: (dialog.appliedWidth - units.smallSpacing * 2) - units.smallSpacing * 3
                text: i18n("Paint contents based on active window scheme")
                checked: plasmoid.configuration.colorizeFromActiveWindowScheme
                tooltip: i18n("The panel contents are colorized from active window scheme \nwhen that window is maximized or is touching the panel.")
                style: LatteCheckBoxStyle{}

                enabled: solidForMaximizedChk.checked || onlyOnMaximizedChk.checked

                onClicked: {
                    plasmoid.configuration.colorizeFromActiveWindowScheme = checked;
                }
            }

            PlasmaComponents.CheckBox {
                id: hideShadowsOnMaximizedChk
                Layout.leftMargin: units.smallSpacing * 2
                text: i18n("Hide panel shadow for maximized windows")
                checked: plasmoid.configuration.disablePanelShadowForMaximized

                onClicked: {
                    plasmoid.configuration.disablePanelShadowForMaximized = checked;
                }
            }
        }
        //! END: Dynamic Background

        //! BEGIN: Behavior
        ColumnLayout {
            spacing: units.smallSpacing
            Layout.rightMargin: units.smallSpacing * 2

            Header {
                text: i18n("Behavior")
            }

            PlasmaComponents.CheckBox {
                Layout.leftMargin: units.smallSpacing * 2
                text: i18n("Activate KWin edge after hiding")
                checked: latteView.visibility.enableKWinEdges

                onClicked: {
                    latteView.visibility.enableKWinEdges = checked;
                }
            }

            PlasmaComponents.CheckBox {
                Layout.leftMargin: units.smallSpacing * 2
                text: i18n("Decrease applets size when it is needed")
                checked: plasmoid.configuration.autoDecreaseIconSize
                tooltip: i18n("Applets size is decreased automatically when the contents \nexceed the maximum length \n\nHint: this option is disabled when only plasma taskmanagers are present")
                enabled: !(latteView.tasksPresent() && !latteView.latteTasksPresent());

                onClicked: {
                    plasmoid.configuration.autoDecreaseIconSize = checked
                }
            }

            PlasmaComponents.CheckBox {
                Layout.leftMargin: units.smallSpacing * 2
                text: i18n("Add launchers only in the corresponding area")
                checked: plasmoid.configuration.addLaunchersInTaskManager
                tooltip: i18n("Launchers are added only in the taskmanager and not as plasma applets")

                onClicked: {
                    plasmoid.configuration.addLaunchersInTaskManager = checked;
                }
            }

            PlasmaComponents.CheckBox {
                Layout.leftMargin: units.smallSpacing * 2
                text: i18n("Prefer for global shortcuts activation")
                checked: latteView.isPreferredForShortcuts

                tooltip: i18n("Enable highest priority for global shortcuts activation")

                onClicked: {
                    latteView.isPreferredForShortcuts = checked
                }
            }

            PlasmaComponents.CheckBox {
                Layout.leftMargin: units.smallSpacing * 2
                text: i18n("Above fullscreen windows")
                checked: latteView.byPassWM
                enabled: !(latteView.visibility.mode === Latte.Types.AlwaysVisible
                           || latteView.visibility.mode === Latte.Types.WindowsGoBelow)

                tooltip: i18n("BypassWindowManagerHint flag for the window.\nThe view will be above all windows even those set as 'Always On Top'")

                onCheckedChanged: {
                    latteView.byPassWM = checked;
                }
            }

            PlasmaComponents.CheckBox {
                Layout.leftMargin: units.smallSpacing * 2
                text: i18n("Raise on desktop change")
                checked: latteView.visibility.raiseOnDesktop
                enabled: latteView.visibility.mode !== Latte.Types.AlwaysVisible

                onClicked: {
                    latteView.visibility.raiseOnDesktop = checked
                }
            }

            PlasmaComponents.CheckBox {
                Layout.leftMargin: units.smallSpacing * 2
                text: i18n("Raise on activity change")
                checked: latteView.visibility.raiseOnActivity
                enabled: latteView.visibility.mode !== Latte.Types.AlwaysVisible

                onClicked: {
                    latteView.visibility.raiseOnActivity = checked
                }
            }
        }
        //! END: Behavior

        //! BEGIN: Extra Actions
        ColumnLayout {
            Layout.fillWidth: true
            spacing: units.smallSpacing
            Layout.rightMargin: units.smallSpacing * 2

            Header {
                text: i18n("Extra Actions")
            }

            RowLayout {
                Layout.fillWidth: true
                Layout.leftMargin: units.smallSpacing * 2
                spacing: units.smallSpacing

                PlasmaComponents.Button {
                    iconSource: "distribute-horizontal-x"
                    text: i18n("Add Spacer")
                    Layout.minimumWidth: 0.5 * (content.width - 5 * units.smallSpacing)
                    Layout.maximumWidth: Layout.minimumWidth
                    Layout.alignment: Qt.AlignLeft
                    tooltip: i18n("Add a spacer to separate applets")

                    onClicked: {
                        viewConfig.addPanelSpacer()
                    }
                }

                PlasmaComponents.Button {
                    Layout.fillWidth: true
                    iconSource: "edit-delete"
                    text: i18n("Remove Tasks Applet")
                    enabled: latteView.tasksPresent()
                    tooltip: i18n("Remove Latte Tasks plasmoid")

                    onClicked: {
                        latteView.removeTasksPlasmoid();
                    }
                }
            }
        }
        //! END: Extra Actions

        //! Bottom spacer
        PlasmaComponents.Label{
            id: bottomMarginSpacer
            text:" "
        }
    }
}
