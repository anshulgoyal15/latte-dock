/*
*  Copyright 2018  Michail Vourlakos <mvourlakos@gmail.com>
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

#ifndef EFFECTS_H
#define EFFECTS_H

// Qt
#include <QObject>
#include <QPointer>
#include <QRect>

// Plasma
#include <Plasma/FrameSvg>
#include <Plasma/Theme>

namespace Latte {
class View;
}

namespace Latte {
namespace ViewPart {

class Effects: public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool animationsBlocked READ animationsBlocked NOTIFY animationsBlockedChanged)
    Q_PROPERTY(bool colorizerEnabled READ colorizerEnabled WRITE setColorizerEnabled NOTIFY colorizerEnabledChanged)
    Q_PROPERTY(bool drawShadows READ drawShadows WRITE setDrawShadows NOTIFY drawShadowsChanged)
    Q_PROPERTY(bool drawEffects READ drawEffects WRITE setDrawEffects NOTIFY drawEffectsChanged)

    //! thickness shadow size when is drawn inside the window from qml
    Q_PROPERTY(int backgroundOpacity READ backgroundOpacity WRITE setBackgroundOpacity NOTIFY backgroundOpacityChanged)
    Q_PROPERTY(int innerShadow READ innerShadow WRITE setInnerShadow NOTIFY innerShadowChanged)

    Q_PROPERTY(QRect mask READ mask WRITE setMask NOTIFY maskChanged)
    Q_PROPERTY(QRect rect READ rect WRITE setRect NOTIFY rectChanged)

    Q_PROPERTY(Plasma::FrameSvg::EnabledBorders enabledBorders READ enabledBorders NOTIFY enabledBordersChanged)

public:
    Effects(Latte::View *parent);
    virtual ~Effects();

    bool animationsBlocked() const;
    void setAnimationsBlocked(bool blocked);

    bool colorizerEnabled() const;
    void setColorizerEnabled(bool enabled);

    bool drawShadows() const;
    void setDrawShadows(bool draw);

    bool drawEffects() const;
    void setDrawEffects(bool draw);

    bool forceDrawCenteredBorders() const;
    void setForceDrawCenteredBorders(bool draw);

    int backgroundOpacity() const;
    void setBackgroundOpacity(int opacity);

    int innerShadow() const;
    void setInnerShadow(int shadow);

    QRect mask() const;
    void setMask(QRect area);

    QRect rect() const;
    void setRect(QRect area);

    Plasma::FrameSvg::EnabledBorders enabledBorders() const;

public slots:
    void clearShadows();
    void updateShadows();
    void updateEffects();
    void updateEnabledBorders();

signals:
    void animationsBlockedChanged();
    void backgroundOpacityChanged();
    void colorizerEnabledChanged();
    void drawShadowsChanged();
    void drawEffectsChanged();
    void enabledBordersChanged();
    void maskChanged();
    void innerShadowChanged();
    void rectChanged();

private slots:
    void init();

private:
    bool m_animationsBlocked{false};
    bool m_colorizerEnabled{false};
    bool m_drawShadows{true};
    bool m_drawEffects{false};
    bool m_forceDrawCenteredBorders{false};

    int m_backgroundOpacity{100};
    int m_innerShadow{0};

    QRect m_rect;
    QRect m_mask;

    QPointer<Latte::View> m_view;

    Plasma::Theme m_theme;
    //only for the mask on disabled compositing, not to actually paint
    Plasma::FrameSvg *m_background{nullptr};

    //only for the mask, not to actually paint
    Plasma::FrameSvg::EnabledBorders m_enabledBorders{Plasma::FrameSvg::AllBorders};
};

}
}

#endif
