script_name('chechnorma')
script_author('Mico')
script_description('???????? ?????')
script_version('0.0')

require('moonloader')
require('sampfuncs')
local encoding          = require "encoding"
encoding.default        = "CP1251"
u8                      = encoding.UTF8 
local imgui             = require 'imgui'
local inicfg            = require 'inicfg'
local vkeys             = require 'vkeys'
local rkeys             = require 'rkeys'
local fa                = require 'fAwesome5'
local samp              = require("lib.samp.events")
local fa_glyph_ranges   = imgui.ImGlyphRanges({ fa.min_range, fa.max_range })
local sw, sh            = getScreenResolution()
local main_window       = imgui.ImBool(false)
local settings     = imgui.ImBool(false)
local id_stats              = imgui.ImBuffer(256)
local main_color = 0xFF7F50
local tag = "{FF7F50}>> [????? ?????] "
local god = {'??????','???????','?????','??????','???','????','????','???????','????????','???????','??????','???????'}

local ini = inicfg.load({
    config = {
        theme = 1,
        position = 0
    }
}, 'checknorma.ini')
inicfg.save(ini, 'checknorma.ini')


function main()
    if not isSampLoaded() then return end
	while not isSampAvailable() do wait(100) end
    autoupdate("https://raw.githubusercontent.com/MicoExp/check/main/check.json", '['..string.upper(thisScript().name)..']: ', "")
    style()
    
    sampRegisterChatCommand('check', mph)
    sampAddChatMessage(tag..'{FFFFFF}?????? ?????? ?? ????????.', main_color)
    
    while true do
        imgui.ShowCursor = main_window.v or settings.v
        imgui.Process = main_window.v
        wait(0)
        _, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
		nick = sampGetPlayerNickname(id)
        
        if main_window.v == false then
            imgui.Process = false
            imgui.ShowCursor = false
        end
        
    end
end

function save()
    inicfg.save(ini, "checknorma.ini")
end

function mph(args)
    main_window.v = true
end


local arr = os.date("*t")

function imgui.CenterText(text)
    local width = imgui.GetWindowWidth()
	local height = imgui.GetWindowHeight()
    local calc = imgui.CalcTextSize(text)
    imgui.SetCursorPosX( width / 2 - calc.x / 2 )
    imgui.Text(text)
end
local font_25 = nil

function imgui.BeforeDrawFrame()
    if fa_font == nil then
        local font_config = imgui.ImFontConfig() 
        font_config.MergeMode = true
        fa_font = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/resource/fonts/fa-solid-900.ttf',14.0, font_config, fa_glyph_ranges)
        fa_font12 = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/resource/fonts/fa-solid-900.ttf', 12.0, font_config2, fa_glyph_ranges)
    end
    if font_25 == nil then
        font_25 = imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14).. '\\trebucbd.ttf', 25.0, nil, imgui.GetIO().Fonts:GetGlyphRangesCyrillic()) -- ?????? 30 ????? ?????? ??????
    end
    if font_24 == nil then
        font_24 = imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14).. '\\trebucbd.ttf', 28.0, nil, imgui.GetIO().Fonts:GetGlyphRangesCyrillic()) -- ?????? 30 ????? ?????? ??????
    end
    if font_16 == nil then
        font_16 = imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14).. '\\trebucbd.ttf', 18.0, nil, imgui.GetIO().Fonts:GetGlyphRangesCyrillic()) -- ?????? 30 ????? ?????? ??????
    end
end

function FormatTime(time)
    local timezone_offset = 86400 - os.date('%H', 0) * 3600
    local time = time + timezone_offset
    return os.date((os.date("%H",time) == "00" and '%M:%S' or '%H:%M:%S'), time)
end

function imgui.OnDrawFrame( ... )
    if main_window.v then
	    imgui.SetNextWindowSize(imgui.ImVec2(240,215), imgui.Cond.FirstUseEver)
	    imgui.SetNextWindowPos(imgui.ImVec2((sw / 2), sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.Begin(u8'fdtools', main_window, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.ShowBorders + imgui.WindowFlags.AlwaysUseWindowPadding)
        imgui.PushFont(font_25)
        imgui.TextColoredRGB(u8'{D6D6D6}Checker')
        imgui.PopFont()
        imgui.SameLine()
        imgui.SetCursorPosY(25)
        imgui.Hint(u8'{313742}v0.0', u8'?????? ?????? (254)')
        imgui.SameLine()
        imgui.SetCursorPosY(10)
        imgui.SetCursorPosX(196)
        imgui.PushFont(fa_font12)
        if imgui.CloseButton(fa.ICON_FA_TIMES, imgui.ImVec2(30,30)) then
            main_window.v = false
        end
        imgui.PopFont()
        imgui.SetCursorPosY(65)
        imgui.CenterText('?????? ?? ????????')
        imgui.End()
    end
    if settings.v then
	    imgui.SetNextWindowSize(imgui.ImVec2(340,135), imgui.Cond.FirstUseEver)
	    imgui.SetNextWindowPos(imgui.ImVec2((sw / 2), sh / 1.33), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.Begin(u8'##settings', settings, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoMove + imgui.WindowFlags.ShowBorders + imgui.WindowFlags.AlwaysUseWindowPadding)
        if imgui.CircleButton('##orange', ini.config.theme == 1,  imgui.ImVec4(1.00, 0.42, 0.00, 1.00)) then
            ini.config.theme = 1
            inicfg.save(ini, 'fdtools.ini')
            style()
        end
        imgui.SameLine()
        if imgui.CircleButton('##blue', ini.config.theme == 2, imgui.ImVec4(0.28, 0.56, 1.00, 1.00)) then
            ini.config.theme = 2
            inicfg.save(ini, 'fdtools.ini')
            style()
        end
        imgui.SameLine()
        if imgui.CircleButton('##green', ini.config.theme == 3, imgui.ImVec4(0.00, 0.80, 0.38, 1.00)) then
            ini.config.theme = 3
            inicfg.save(ini, 'fdtools.ini')
            style()
        end
        imgui.SameLine()
        if imgui.CircleButton('##pink', ini.config.theme == 4, imgui.ImVec4(0.41, 0.19, 0.63, 1.00)) then
            ini.config.theme = 4
            inicfg.save(ini, 'fdtools.ini')
            style()
        end
        imgui.SetCursorPosY(94)
        if imgui.MenuButton(u8'???????', imgui.ImVec2(310,30)) then
            settings.v = false
        end
        imgui.End()
    end
end

function imgui.NewInputText(lable, val, width, hint, hintpos)
    local hint = hint and hint or ''
    local hintpos = tonumber(hintpos) and tonumber(hintpos) or 1
    local cPos = imgui.GetCursorPos()
    imgui.PushItemWidth(width)
    local result = imgui.InputText(lable, val)
    if #val.v == 0 then
        local hintSize = imgui.CalcTextSize(hint)
        if hintpos == 2 then imgui.SameLine(cPos.x + (width - hintSize.x) / 2)
        elseif hintpos == 3 then imgui.SameLine(cPos.x + (width - hintSize.x - 5))
        else imgui.SameLine(cPos.x + 5) end
        imgui.TextColored(imgui.ImVec4(1.00, 1.00, 1.00, 0.40), tostring(hint))
    end
    imgui.PopItemWidth()
    return result
end

function imgui.Hint(label, description)
    imgui.TextColoredRGB(label)

    if imgui.IsItemHovered() then
        imgui.BeginTooltip()
            imgui.PushTextWrapPos(600)
                imgui.TextUnformatted(description)
            imgui.PopTextWrapPos()
        imgui.EndTooltip()
    end
end

function imgui.MenuNoAButton(text, size)
	imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.142, 0.142, 0.142, 0.254))
	imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.142, 0.142, 0.142, 0.254))
	imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(0.142, 0.142, 0.142, 0.254))
    imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(0.06, 0.05, 0.07, 0.00))
    imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(1, 1, 1, 0.20))
		local button = imgui.Button(text, size)
	imgui.PopStyleColor(5)
	return button
end

function imgui.MenuButton(text, size)
	imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.142, 0.142, 0.142, 0.654))
	imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.142, 0.142, 0.142, 1.654))
	imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(0.142, 0.142, 0.142, 0.654))
    imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(0.06, 0.05, 0.07, 0.00))
    imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(1, 1, 1, 0.90))
		local button = imgui.Button(text, size)
	imgui.PopStyleColor(5)
	return button
end

function imgui.TextColoredRGB(text)
    local style = imgui.GetStyle()
    local colors = style.Colors
    local ImVec4 = imgui.ImVec4

    local explode_argb = function(argb)
        local a = bit.band(bit.rshift(argb, 24), 0xFF)
        local r = bit.band(bit.rshift(argb, 16), 0xFF)
        local g = bit.band(bit.rshift(argb, 8), 0xFF)
        local b = bit.band(argb, 0xFF)
        return a, r, g, b
    end

    local getcolor = function(color)
        if color:sub(1, 6):upper() == 'SSSSSS' then
            local r, g, b = colors[1].x, colors[1].y, colors[1].z
            local a = tonumber(color:sub(7, 8), 16) or colors[1].w * 255
            return ImVec4(r, g, b, a / 255)
        end
        local color = type(color) == 'string' and tonumber(color, 16) or color
        if type(color) ~= 'number' then return end
        local r, g, b, a = explode_argb(color)
        return imgui.ImColor(r, g, b, a):GetVec4()
    end

    local render_text = function(text_)
        for w in text_:gmatch('[^\r\n]+') do
            local text, colors_, m = {}, {}, 1
            w = w:gsub('{(......)}', '{%1FF}')
            while w:find('{........}') do
                local n, k = w:find('{........}')
                local color = getcolor(w:sub(n + 1, k - 1))
                if color then
                    text[#text], text[#text + 1] = w:sub(m, n - 1), w:sub(k + 1, #w)
                    colors_[#colors_ + 1] = color
                    m = n
                end
                w = w:sub(1, n - 1) .. w:sub(k + 1, #w)
            end
            if text[0] then
                for i = 0, #text do
                    imgui.TextColored(colors_[i] or colors[1], u8(text[i]))
                    imgui.SameLine(nil, 0)
                end
                imgui.NewLine()
            else imgui.Text(u8(w)) end
        end
    end

    render_text(text)
end

function imgui.AnimatedButton(label, size, speed, rounded)
    local size = size or imgui.ImVec2(0, 0)
    local bool = false
    local text = label:gsub('##.+$', '')
    local ts = imgui.CalcTextSize(text)
    speed = speed and speed or 0.4
    if not AnimatedButtons then AnimatedButtons = {} end
    if not AnimatedButtons[label] then
        local color = imgui.GetStyle().Colors[imgui.Col.ButtonHovered]
        AnimatedButtons[label] = {circles = {}, hovered = false, state = false, time = os.clock(), color = imgui.ImVec4(color.x, color.y, color.z, 0.2)}
    end
    local button = AnimatedButtons[label]
    local dl = imgui.GetWindowDrawList()
    local p = imgui.GetCursorScreenPos()
    local c = imgui.GetCursorPos()
    local CalcItemSize = function(size, width, height)
        local region = imgui.GetContentRegionMax()
        if (size.x == 0) then
            size.x = width
        elseif (size.x < 0) then
            size.x = math.max(4.0, region.x - c.x + size.x);
        end
        if (size.y == 0) then
            size.y = height;
        elseif (size.y < 0) then
            size.y = math.max(4.0, region.y - c.y + size.y);
        end
        return size
    end
    size = CalcItemSize(size, ts.x+imgui.GetStyle().FramePadding.x*2, ts.y+imgui.GetStyle().FramePadding.y*2)
    local ImSaturate = function(f) return f < 0.0 and 0.0 or (f > 1.0 and 1.0 or f) end
    if #button.circles > 0 then
        local PathInvertedRect = function(a, b, col)
            local rounding = rounded and imgui.GetStyle().FrameRounding or 0
            if rounding <= 0 or not rounded then return end
            local dl = imgui.GetWindowDrawList()
            dl:PathLineTo(a)
            dl:PathArcTo(imgui.ImVec2(a.x + rounding, a.y + rounding), rounding, -3.0, -1.5)
            dl:PathFillConvex(col)

            dl:PathLineTo(imgui.ImVec2(b.x, a.y))
            dl:PathArcTo(imgui.ImVec2(b.x - rounding, a.y + rounding), rounding, -1.5, -0.205)
            dl:PathFillConvex(col)

            dl:PathLineTo(imgui.ImVec2(b.x, b.y))
            dl:PathArcTo(imgui.ImVec2(b.x - rounding, b.y - rounding), rounding, 1.5, 0.205)
            dl:PathFillConvex(col)

            dl:PathLineTo(imgui.ImVec2(a.x, b.y))
            dl:PathArcTo(imgui.ImVec2(a.x + rounding, b.y - rounding), rounding, 3.0, 1.5)
            dl:PathFillConvex(col)
        end
        for i, circle in ipairs(button.circles) do
            local time = os.clock() - circle.time
            local t = ImSaturate(time / speed)
            local color = imgui.GetStyle().Colors[imgui.Col.ButtonActive]
            local color = imgui.GetColorU32(imgui.ImVec4(color.x, color.y, color.z, (circle.reverse and (255-255*t) or (255*t))/255))
            local radius = math.max(size.x, size.y) * (circle.reverse and 1.5 or t)
            imgui.PushClipRect(p, imgui.ImVec2(p.x+size.x, p.y+size.y), true)
            dl:AddCircleFilled(circle.clickpos, radius, color, radius/2)
            PathInvertedRect(p, imgui.ImVec2(p.x+size.x, p.y+size.y), imgui.GetColorU32(imgui.GetStyle().Colors[imgui.Col.WindowBg]))
            imgui.PopClipRect()
            if t == 1 then
                if not circle.reverse then
                    circle.reverse = true
                    circle.time = os.clock()
                else
                    table.remove(button.circles, i)
                end
            end
        end
    end
    local t = ImSaturate((os.clock()-button.time) / speed)
    button.color.w = button.color.w + (button.hovered and 0.8 or -0.8)*t
    button.color.w = button.color.w < 0.2 and 0.2 or (button.color.w > 1 and 1 or button.color.w)
    color = imgui.GetStyle().Colors[imgui.Col.Button]
    color = imgui.GetColorU32(imgui.ImVec4(color.x, color.y, color.z, 0.2))
    dl:AddRectFilled(p, imgui.ImVec2(p.x+size.x, p.y+size.y), color, rounded and imgui.GetStyle().FrameRounding or 0)
    dl:AddRect(p, imgui.ImVec2(p.x+size.x, p.y+size.y), imgui.GetColorU32(button.color), rounded and imgui.GetStyle().FrameRounding or 0)
    local align = imgui.GetStyle().ButtonTextAlign
    imgui.SetCursorPos(imgui.ImVec2(c.x+(size.x-ts.x)*align.x, c.y+(size.y-ts.y)*align.y))
    imgui.Text(text)
    imgui.SetCursorPos(c)
    if imgui.InvisibleButton(label, size) then
        bool = true
        table.insert(button.circles, {animate = true, reverse = false, time = os.clock(), clickpos = imgui.ImVec2(getCursorPos())})
    end
    button.hovered = imgui.IsItemHovered()
    if button.hovered ~= button.state then
        button.state = button.hovered
        button.time = os.clock()
    end
    return bool
end

function imgui.CloseButton(text, size)
	imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.45, 0.06, 0.06, 0.00))
	imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.75, 0.15, 0.15, 0.00))
	imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(0.35, 0.03, 0.03, 0.00))
    imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(0.06, 0.05, 0.07, 0.00))
    imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(1, 1, 1, 0.50))
		local button = imgui.Button(text, size)
	imgui.PopStyleColor(5)
	return button
end
function imgui.CircleButton(str_id, bool, color4, radius, isimage)
	local rBool = false

	local p = imgui.GetCursorScreenPos()
	local isimage = isimage or false
	local radius = radius or 10
	local draw_list = imgui.GetWindowDrawList()
	if imgui.InvisibleButton(str_id, imgui.ImVec2(23, 23)) then
		rBool = true
	end

	draw_list:AddCircleFilled(imgui.ImVec2(p.x + radius, p.y + radius), radius-3, imgui.ColorConvertFloat4ToU32(isimage and imgui.ImVec4(0,0,0,0) or color4))

	if bool then
		draw_list:AddCircle(imgui.ImVec2(p.x + radius, p.y + radius), radius, imgui.ColorConvertFloat4ToU32(color4),_,1.5)
	end

	imgui.SetCursorPosY(imgui.GetCursorPosY()+radius)
	return rBool
end

function style()
    imgui.SwitchContext()
        local style = imgui.GetStyle()
        local style = imgui.GetStyle()
        local colors = style.Colors
        local clr = imgui.Col
        local ImVec4 = imgui.ImVec4
        local ImVec2 = imgui.ImVec2

        style.WindowPadding       = ImVec2(16, 16)
        style.WindowRounding      = 6
        style.ChildWindowRounding = 6
        style.FramePadding        = ImVec2(5, 5)
        style.FrameRounding       = 5
        style.ItemSpacing         = ImVec2(8, 6)
        style.TouchExtraPadding   = ImVec2(0, 0)
        style.IndentSpacing       = 25
        style.ScrollbarSize       = 15
        style.ScrollbarRounding   = 6
        style.GrabMinSize         = 5
        style.GrabRounding        = 3
        style.WindowTitleAlign    = ImVec2(0.5, 0.5)
        style.ButtonTextAlign     = ImVec2(0.5, 0.5)

    if ini.config.theme == 1 or ini.config.theme == nil then
        colors[clr.Text] = ImVec4(1.00, 1.00, 1.00, 1.00)
        colors[clr.TextDisabled] = ImVec4(1.815, 1.388, 1.051, 0.500)
        colors[clr.WindowBg] = ImVec4(0.06, 0.05, 0.07, 0.93)
        colors[clr.ChildWindowBg] = ImVec4(0.07, 0.07, 0.09, 1.00)
        colors[clr.PopupBg] = ImVec4(0.07, 0.07, 0.09, 1.00)
        colors[clr.Border] = ImVec4(0.80, 0.80, 0.83, 0.38)
        colors[clr.BorderShadow] = ImVec4(0.92, 0.91, 0.88, 0.00)
        colors[clr.FrameBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
        colors[clr.FrameBgHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
        colors[clr.FrameBgActive] = ImVec4(0.56, 0.56, 0.58, 1.00)
        colors[clr.TitleBg] = ImVec4(0.76, 0.31, 0.00, 1.00)
        colors[clr.TitleBgCollapsed] = ImVec4(1.00, 0.98, 0.95, 0.75)
        colors[clr.TitleBgActive] = ImVec4(0.80, 0.33, 0.00, 1.00)
        colors[clr.MenuBarBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
        colors[clr.ScrollbarBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
        colors[clr.ScrollbarGrab] = ImVec4(0.80, 0.80, 0.83, 0.31)
        colors[clr.ScrollbarGrabHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
        colors[clr.ScrollbarGrabActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
        colors[clr.ComboBg] = ImVec4(0.19, 0.18, 0.21, 1.00)
        colors[clr.CheckMark] = ImVec4(1.00, 0.42, 0.00, 0.53)
        colors[clr.SliderGrab] = ImVec4(1.00, 0.42, 0.00, 0.53)
        colors[clr.SliderGrabActive] = ImVec4(1.00, 0.42, 0.00, 1.00)
        colors[clr.Button] = ImVec4(0.10, 0.09, 0.12, 1.00)
        colors[clr.ButtonHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
        colors[clr.ButtonActive] = ImVec4(0.56, 0.56, 0.58, 1.00)
        colors[clr.Header] = ImVec4(0.10, 0.09, 0.12, 1.00)
        colors[clr.HeaderHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
        colors[clr.HeaderActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
        colors[clr.ResizeGrip] = ImVec4(0.00, 0.00, 0.00, 0.00)
        colors[clr.ResizeGripHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
        colors[clr.ResizeGripActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
        colors[clr.CloseButton] = ImVec4(0.40, 0.39, 0.38, 0.16)
        colors[clr.CloseButtonHovered] = ImVec4(0.40, 0.39, 0.38, 0.39)
        colors[clr.CloseButtonActive] = ImVec4(0.40, 0.39, 0.38, 1.00)
        colors[clr.PlotLines] = ImVec4(0.40, 0.39, 0.38, 0.63)
        colors[clr.PlotLinesHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
        colors[clr.PlotHistogram] = ImVec4(0.40, 0.39, 0.38, 0.63)
        colors[clr.PlotHistogramHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
        colors[clr.TextSelectedBg] = ImVec4(0.25, 1.00, 0.00, 0.43)
        colors[clr.ModalWindowDarkening] = ImVec4(1.00, 0.98, 0.95, 0.73)
    elseif ini.config.theme == 2 then
        colors[clr.Text] = ImVec4(1.00, 1.00, 1.00, 1.00)
        colors[clr.TextDisabled] = ImVec4(0.28, 0.56, 1.00, 1.00)
        colors[clr.WindowBg] = ImVec4(0.11, 0.15, 0.17, 0.93)
        colors[clr.ChildWindowBg] = ImVec4(0.15, 0.18, 0.22, 0.00)
        colors[clr.PopupBg] = ImVec4(0.08, 0.08, 0.08, 0.94)
        colors[clr.Border] = ImVec4(0.43, 0.43, 0.50, 0.50)
        colors[clr.BorderShadow] = ImVec4(0.00, 0.00, 0.00, 0.00)
        colors[clr.FrameBg] = ImVec4(0.20, 0.25, 0.29, 1.00)
        colors[clr.FrameBgHovered] = ImVec4(0.12, 0.20, 0.28, 1.00)
        colors[clr.FrameBgActive] = ImVec4(0.09, 0.12, 0.14, 1.00)
        colors[clr.TitleBg] = ImVec4(0.09, 0.12, 0.14, 0.65)
        colors[clr.TitleBgCollapsed] = ImVec4(0.00, 0.00, 0.00, 0.51)
        colors[clr.TitleBgActive] = ImVec4(0.08, 0.10, 0.12, 1.00)
        colors[clr.MenuBarBg] = ImVec4(0.15, 0.18, 0.22, 1.00)
        colors[clr.ScrollbarBg] = ImVec4(0.02, 0.02, 0.02, 0.39)
        colors[clr.ScrollbarGrab] = ImVec4(0.20, 0.25, 0.29, 1.00)
        colors[clr.ScrollbarGrabHovered] = ImVec4(0.18, 0.22, 0.25, 1.00)
        colors[clr.ScrollbarGrabActive] = ImVec4(0.09, 0.21, 0.31, 1.00)
        colors[clr.ComboBg] = ImVec4(0.20, 0.25, 0.29, 1.00)
        colors[clr.CheckMark] = ImVec4(0.28, 0.56, 1.00, 1.00)
        colors[clr.SliderGrab] = ImVec4(0.28, 0.56, 1.00, 1.00)
        colors[clr.SliderGrabActive] = ImVec4(0.37, 0.61, 1.00, 1.00)
        colors[clr.Button] = ImVec4(0.20, 0.25, 0.29, 1.00)
        colors[clr.ButtonHovered] = ImVec4(0.28, 0.56, 1.00, 1.00)
        colors[clr.ButtonActive] = ImVec4(0.06, 0.53, 0.98, 1.00)
        colors[clr.Header] = ImVec4(0.20, 0.25, 0.29, 0.55)
        colors[clr.HeaderHovered] = ImVec4(0.26, 0.59, 0.98, 0.80)
        colors[clr.HeaderActive] = ImVec4(0.26, 0.59, 0.98, 1.00)
        colors[clr.ResizeGrip] = ImVec4(0.26, 0.59, 0.98, 0.25)
        colors[clr.ResizeGripHovered] = ImVec4(0.26, 0.59, 0.98, 0.67)
        colors[clr.ResizeGripActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
        colors[clr.CloseButton] = ImVec4(0.40, 0.39, 0.38, 0.16)
        colors[clr.CloseButtonHovered] = ImVec4(0.40, 0.39, 0.38, 0.39)
        colors[clr.CloseButtonActive] = ImVec4(0.40, 0.39, 0.38, 1.00)
        colors[clr.PlotLines] = ImVec4(0.61, 0.61, 0.61, 1.00)
        colors[clr.PlotLinesHovered] = ImVec4(1.00, 0.43, 0.35, 1.00)
        colors[clr.PlotHistogram] = ImVec4(0.90, 0.70, 0.00, 1.00)
        colors[clr.PlotHistogramHovered] = ImVec4(1.00, 0.60, 0.00, 1.00)
        colors[clr.TextSelectedBg]          = ImVec4(0.25, 1.00, 0.00, 0.43)
        colors[clr.ModalWindowDarkening]   = ImVec4(1.00, 0.98, 0.95, 0.73)
    elseif ini.config.theme == 3 then
        colors[clr.Text]                   = ImVec4(0.90, 0.90, 0.90, 1.00)
        colors[clr.TextDisabled]           = ImVec4(0.00, 0.80, 0.38, 1.00)
        colors[clr.WindowBg]               = ImVec4(0.08, 0.08, 0.08, 0.93)
        colors[clr.ChildWindowBg]          = ImVec4(0.10, 0.10, 0.10, 0.00)
        colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 1.00)
        colors[clr.Border]                 = ImVec4(0.70, 0.70, 0.70, 0.40)
        colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
        colors[clr.FrameBg]                = ImVec4(0.15, 0.15, 0.15, 1.00)
        colors[clr.FrameBgHovered]         = ImVec4(0.19, 0.19, 0.19, 0.71)
        colors[clr.FrameBgActive]          = ImVec4(0.34, 0.34, 0.34, 0.79)
        colors[clr.TitleBg]                = ImVec4(0.00, 0.69, 0.33, 0.80)
        colors[clr.TitleBgActive]          = ImVec4(0.00, 0.74, 0.36, 1.00)
        colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.69, 0.33, 0.50)
        colors[clr.MenuBarBg]              = ImVec4(0.00, 0.80, 0.38, 1.00)
        colors[clr.ScrollbarBg]            = ImVec4(0.16, 0.16, 0.16, 1.00)
        colors[clr.ScrollbarGrab]          = ImVec4(0.00, 0.69, 0.33, 1.00)
        colors[clr.ScrollbarGrabHovered]   = ImVec4(0.00, 0.82, 0.39, 1.00)
        colors[clr.ScrollbarGrabActive]    = ImVec4(0.00, 1.00, 0.48, 1.00)
        colors[clr.ComboBg]                = ImVec4(0.20, 0.20, 0.20, 0.99)
        colors[clr.CheckMark]              = ImVec4(0.00, 0.69, 0.33, 1.00)
        colors[clr.SliderGrab]             = ImVec4(0.00, 0.69, 0.33, 1.00)
        colors[clr.SliderGrabActive]       = ImVec4(0.00, 0.77, 0.37, 1.00)
        colors[clr.Button]                 = ImVec4(0.00, 0.69, 0.33, 1.00)
        colors[clr.ButtonHovered]          = ImVec4(0.00, 0.82, 0.39, 1.00)
        colors[clr.ButtonActive]           = ImVec4(0.00, 0.87, 0.42, 1.00)
        colors[clr.Header]                 = ImVec4(0.00, 0.69, 0.33, 1.00)
        colors[clr.HeaderHovered]          = ImVec4(0.00, 0.76, 0.37, 0.57)
        colors[clr.HeaderActive]           = ImVec4(0.00, 0.88, 0.42, 0.89)
        colors[clr.Separator]              = ImVec4(1.00, 1.00, 1.00, 0.40)
        colors[clr.SeparatorHovered]       = ImVec4(1.00, 1.00, 1.00, 0.60)
        colors[clr.SeparatorActive]        = ImVec4(1.00, 1.00, 1.00, 0.80)
        colors[clr.ResizeGrip]             = ImVec4(0.00, 0.69, 0.33, 1.00)
        colors[clr.ResizeGripHovered]      = ImVec4(0.00, 0.76, 0.37, 1.00)
        colors[clr.ResizeGripActive]       = ImVec4(0.00, 0.86, 0.41, 1.00)
        colors[clr.CloseButton]            = ImVec4(0.00, 0.82, 0.39, 1.00)
        colors[clr.CloseButtonHovered]     = ImVec4(0.00, 0.88, 0.42, 1.00)
        colors[clr.CloseButtonActive]      = ImVec4(0.00, 1.00, 0.48, 1.00)
        colors[clr.PlotLines]              = ImVec4(0.00, 0.69, 0.33, 1.00)
        colors[clr.PlotLinesHovered]       = ImVec4(0.00, 0.74, 0.36, 1.00)
        colors[clr.PlotHistogram]          = ImVec4(0.00, 0.69, 0.33, 1.00)
        colors[clr.PlotHistogramHovered]   = ImVec4(0.00, 0.80, 0.38, 1.00)
        colors[clr.TextSelectedBg]         = ImVec4(0.00, 0.69, 0.33, 0.72)
        colors[clr.ModalWindowDarkening]   = ImVec4(0.17, 0.17, 0.17, 0.48)
    elseif ini.config.theme == 4 then
        colors[clr.Text]					= ImVec4(1.00, 1.00, 1.00, 1.00)
        colors[clr.TextDisabled]            = ImVec4(0.41, 0.19, 0.63, 1.00)
		colors[clr.WindowBg]				= ImVec4(0.14, 0.12, 0.16, 0.93)
		colors[clr.ChildWindowBg]		 	= ImVec4(0.30, 0.20, 0.39, 0.00)
		colors[clr.PopupBg]					= ImVec4(0.05, 0.05, 0.10, 0.90)
		colors[clr.Border]					= ImVec4(0.89, 0.85, 0.92, 0.30)
		colors[clr.BorderShadow]			= ImVec4(0.00, 0.00, 0.00, 0.00)
		colors[clr.FrameBg]					= ImVec4(0.30, 0.20, 0.39, 1.00)
		colors[clr.FrameBgHovered]			= ImVec4(0.41, 0.19, 0.63, 0.68)
		colors[clr.FrameBgActive]		 	= ImVec4(0.41, 0.19, 0.63, 1.00)
		colors[clr.TitleBg]			   		= ImVec4(0.41, 0.19, 0.63, 0.45)
		colors[clr.TitleBgCollapsed]	  	= ImVec4(0.41, 0.19, 0.63, 0.35)
		colors[clr.TitleBgActive]		 	= ImVec4(0.41, 0.19, 0.63, 0.78)
		colors[clr.MenuBarBg]			 	= ImVec4(0.30, 0.20, 0.39, 0.57)
		colors[clr.ScrollbarBg]		   		= ImVec4(0.30, 0.20, 0.39, 1.00)
		colors[clr.ScrollbarGrab]		 	= ImVec4(0.41, 0.19, 0.63, 0.31)
		colors[clr.ScrollbarGrabHovered]  	= ImVec4(0.41, 0.19, 0.63, 0.78)
		colors[clr.ScrollbarGrabActive]   	= ImVec4(0.41, 0.19, 0.63, 1.00)
		colors[clr.CheckMark]			 	= ImVec4(0.56, 0.61, 1.00, 1.00)
		colors[clr.SliderGrab]				= ImVec4(0.41, 0.19, 0.63, 0.24)
		colors[clr.SliderGrabActive]	  	= ImVec4(0.41, 0.19, 0.63, 1.00)
		colors[clr.Button]					= ImVec4(0.41, 0.19, 0.63, 0.44)
		colors[clr.ButtonHovered]		 	= ImVec4(0.41, 0.19, 0.63, 0.86)
		colors[clr.ButtonActive]		  	= ImVec4(0.64, 0.33, 0.94, 1.00)
		colors[clr.Header]					= ImVec4(0.41, 0.19, 0.63, 0.76)
		colors[clr.HeaderHovered]		 	= ImVec4(0.41, 0.19, 0.63, 0.86)
		colors[clr.HeaderActive]		  	= ImVec4(0.41, 0.19, 0.63, 1.00)
		colors[clr.ResizeGrip]				= ImVec4(0.41, 0.19, 0.63, 0.20)
		colors[clr.ResizeGripHovered]	 	= ImVec4(0.41, 0.19, 0.63, 0.78)
		colors[clr.ResizeGripActive]	  	= ImVec4(0.41, 0.19, 0.63, 1.00)
		colors[clr.PlotLines]			 	= ImVec4(0.89, 0.85, 0.92, 0.63)
		colors[clr.PlotLinesHovered]	  	= ImVec4(0.41, 0.19, 0.63, 1.00)
		colors[clr.PlotHistogram]		 	= ImVec4(0.89, 0.85, 0.92, 0.63)
		colors[clr.PlotHistogramHovered]  	= ImVec4(0.41, 0.19, 0.63, 1.00)
		colors[clr.TextSelectedBg]			= ImVec4(0.41, 0.19, 0.63, 0.43)
		colors[clr.ModalWindowDarkening]  		= ImVec4(0.20, 0.20, 0.20, 0.35)
    elseif ini.config.theme == 5 then
        colors[clr.Text]					= ImVec4(0.00, 0.00, 0.00, 0.51)
		colors[clr.TextDisabled]   			= ImVec4(0.00, 0.35, 1.00, 0.78)
		colors[clr.WindowBg]				= ImVec4(1.00, 1.00, 1.00, 0.93)
		colors[clr.ChildWindowBg]					= ImVec4(0.96, 0.96, 0.96, 1.00)
		colors[clr.PopupBg]			  		= ImVec4(0.92, 0.92, 0.92, 1.00)
		colors[clr.Border]			   		= ImVec4(0.00, 0.49, 1.00, 0.78)
		colors[clr.BorderShadow]		 	= ImVec4(0.00, 0.00, 0.00, 0.00)
		colors[clr.FrameBg]			  		= ImVec4(0.68, 0.68, 0.68, 0.50)
		colors[clr.FrameBgHovered]	   		= ImVec4(0.82, 0.82, 0.82, 1.00)
		colors[clr.FrameBgActive]			= ImVec4(0.76, 0.76, 0.76, 1.00)
		colors[clr.TitleBg]			  		= ImVec4(0.00, 0.45, 1.00, 0.82)
		colors[clr.TitleBgCollapsed]	 	= ImVec4(0.00, 0.45, 1.00, 0.82)
		colors[clr.TitleBgActive]			= ImVec4(0.00, 0.45, 1.00, 0.82)
		colors[clr.MenuBarBg]				= ImVec4(0.00, 0.37, 0.78, 1.00)
		colors[clr.ScrollbarBg]		  		= ImVec4(0.00, 0.00, 0.00, 0.00)
		colors[clr.ScrollbarGrab]			= ImVec4(0.00, 0.35, 1.00, 0.78)
		colors[clr.ScrollbarGrabHovered] 	= ImVec4(0.00, 0.33, 1.00, 0.84)
		colors[clr.ScrollbarGrabActive]  	= ImVec4(0.00, 0.31, 1.00, 0.88)
		colors[clr.CheckMark]				= ImVec4(0.00, 0.49, 1.00, 0.59)
		colors[clr.SliderGrab]		   		= ImVec4(0.00, 0.49, 1.00, 0.59)
		colors[clr.SliderGrabActive]	 	= ImVec4(0.00, 0.39, 1.00, 0.71)
		colors[clr.Button]			   		= ImVec4(0.00, 0.49, 1.00, 0.59)
		colors[clr.ButtonHovered]			= ImVec4(0.00, 0.49, 1.00, 0.71)
		colors[clr.ButtonActive]		 	= ImVec4(0.00, 0.49, 1.00, 0.78)
		colors[clr.Header]			   		= ImVec4(0.00, 0.49, 1.00, 0.78)
		colors[clr.HeaderHovered]			= ImVec4(0.00, 0.49, 1.00, 0.71)
		colors[clr.HeaderActive]		 	= ImVec4(0.00, 0.49, 1.00, 0.78)
		colors[clr.Separator]			  	= ImVec4(0.00, 0.00, 0.00, 0.51)
		colors[clr.SeparatorHovered]	   	= ImVec4(0.00, 0.00, 0.00, 0.51)
		colors[clr.SeparatorActive]			= ImVec4(0.00, 0.00, 0.00, 0.51)
		colors[clr.ResizeGrip]		   		= ImVec4(0.00, 0.39, 1.00, 0.59)
		colors[clr.ResizeGripHovered]		= ImVec4(0.00, 0.27, 1.00, 0.59)
		colors[clr.ResizeGripActive]	 	= ImVec4(0.00, 0.25, 1.00, 0.63)
		colors[clr.PlotLines]				= ImVec4(0.00, 0.39, 1.00, 0.75)
		colors[clr.PlotLinesHovered]	 	= ImVec4(0.00, 0.39, 1.00, 0.75)
		colors[clr.PlotHistogram]			= ImVec4(0.00, 0.39, 1.00, 0.75)
		colors[clr.PlotHistogramHovered]	= ImVec4(0.00, 0.35, 0.92, 0.78)
		colors[clr.TextSelectedBg]			= ImVec4(0.00, 0.47, 1.00, 0.59)
		colors[clr.ModalWindowDarkening] 		= ImVec4(0.88, 0.88, 0.88, 0.35)

    else 
        ini.config.theme = 1
        style()
    end
end

function autoupdate(json_url, prefix, url)
    local dlstatus = require('moonloader').download_status
    local json = getWorkingDirectory() .. '\\'..thisScript().name..'-version.json'
    if doesFileExist(json) then os.remove(json) end
    downloadUrlToFile(json_url, json,
      function(id, status, p1, p2)
        if status == dlstatus.STATUSEX_ENDDOWNLOAD then
          if doesFileExist(json) then
            local f = io.open(json, 'r')
            if f then
              local info = decodeJson(f:read('*a'))
              updatelink = info.updateurl
              updateversion = info.latest
              f:close()
              os.remove(json)
              if updateversion ~= thisScript().version then
                lua_thread.create(function(prefix)
                  local dlstatus = require('moonloader').download_status
                  local color = -1
                  sampAddChatMessage((tag..'{FFFFFF}???? ?????????? ?? ????? ?????? {FF7F50}'..updateversion), main_color)
                  wait(250)
                  downloadUrlToFile(updatelink, thisScript().path,
                    function(id3, status1, p13, p23)
                      if status1 == dlstatus.STATUS_DOWNLOADINGDATA then
                        print(string.format('????????? %d ?? %d.', p13, p23))
                      elseif status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
                        print('???????? ?????????? ?????????.')
                        sampAddChatMessage((tag..'{FFFFFF}?????????? ?? ?????? {FF7F50}'..updateversion..'{FFFFFF} ?????? ???????!'), main_color)
                        updates.v = true
                        goupdatestatus = true
                        lua_thread.create(function() wait(500) thisScript():reload() end)
                      end
                      if status1 == dlstatus.STATUSEX_ENDDOWNLOAD then
                        if goupdatestatus == nil then
                          sampAddChatMessage((tag..'{FFFFFF}?????????? ?? ?????? {FF7F50}'..updateversion..'{FFFFFF} ?????? ????????!'), main_color)
                                  update = false
                        end
                      end
                    end
                  )
                  end, prefix
                )
              else
                update = false
                print('v'..thisScript().version..': ?????????? ?? ?????????.')
              end
            end
          else
            print('v'..thisScript().version..': ?? ???? ????????? ??????????. ????????? ??? ????????? ?????????????? ?? '..url)
            update = false
          end
        end
      end
    )
    while update ~= false do wait(100) end
  end