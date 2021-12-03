function darkBackground(varargin)
%{
Give a figure a dark background and appropriately change other aspects.
More comprehensive version of Elsa Birch's darkBackground()
** Majority of code (and credit) is from Elsa Birch's darkBackground()
function. It can be found at: https://www.mathworks.com/matlabcentral/fileexchange/30222-quick-dark-or-custom-plot-background

INPUTS:
varargin:
hFigure: figure handle 
backColor: rgb vector for desired background, default = black
foreColor: rgb vector for desired foreground, default = white
invert: invert color of object if same as desired back, default = true
%}

% parse inputs
p = inputParser();
rgbValid = @(x) isvector(x) & length(x) == 3 & sum(x >= 0 & x <= 1) == 3;
addParameter(p, 'hFigure', gcf(), @(x) strcmpi(class(x), 'matlab.ui.Figure'));
addParameter(p, 'backColor', [0,0,0], rgbValid);
addParameter(p, 'foreColor', [1,1,1], rgbValid);
addParameter(p, 'invert', true, @islogical); 
parse(p, varargin{:});

% run function that recolors all relevent children in hierarchy of hFigure
recolorChildren(p.Results.hFigure,p.Results.backColor,p.Results.foreColor, ...
    p.Results.invert)

end

% Sub functions 
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

% recolorChildren (Contains main functionality of darkBackground.m)
function [] = recolorChildren(hObject,backColor,foreColor, invert)

% find all handles, including those that are hiddn of all children in the
% hierarchy under hObject
hChild = findall(hObject);

for iChild = 1:length(hChild)
    % get child type
    typeChild = get(hChild(iChild),'Type');
    % types of objects, and how to treat them
    switch typeChild
        case 'figure'
            % set figure background color
            set(hChild(iChild),'color',backColor)
        case 'axes'
            % Test axes tag since legends are also axes type, but require
            % differnt recoloring steps
            tagAxes = get(hChild(iChild),'Tag');
            if isempty(tagAxes)
                % Color: Color of the axes back planes. ({none} | ColorSpec)
                set(hChild(iChild),'Color','none')

                % XColor, YColor, ZColor: Color of axis lines, ticks, tick labels
                set(hChild(iChild),'XColor',foreColor)
                set(hChild(iChild),'YColor',foreColor)
                if strcmpi(get(hChild(iChild), 'yaxislocation'), 'right') % if on right axis 
                    yyaxis left
                    set(hChild(iChild),'YColor',foreColor) % color left
                    yyaxis right % back to right side 
                end
                set(hChild(iChild),'ZColor',foreColor)

                % ? Visible: Axes/ticks visible ({on} | off)

                % Children:
                % image, light, line, patch, rectangle, surface, and text.
                % hidden(x-, y-, and z-axes and the title)
            elseif strcmp(tagAxes,'Legend')
                % Color: Color of the axes back planes. ({none} | ColorSpec)
                % Make backColor in case of Legend, so that it is opaque if
                % it overlays plot elements
                set(hChild(iChild),'Color',backColor)
                % Although this seems like it should be taken care of by
                % text type, for a few legends it is not (no idea why)
                set(hChild(iChild),'TextColor',foreColor)
                % Set Edgecolor to foreColor
                set(hChild(iChild),'EdgeColor',foreColor)
            else
                
            end
            % grid lines 
            if strcmpi(hChild(iChild).XGrid, 'on') || ...
                    strcmpi(hChild(iChild).YGrid, 'on') || ...
                    strcmpi(hChild(iChild).ZGrid, 'on')
                set(hChild(iChild), 'GridColor', foreColor); 
                set(hChild(iChild), 'MinorGridColor', foreColor); 
            end
        case 'legend'
            % Color: Color of the axes back planes. ({none} | ColorSpec)
            % Make backColor in case of Legend, so that it is opaque if
            % it overlays plot elements
            set(hChild(iChild),'Color',backColor)
            % Although this seems like it should be taken care of by
            % text type, for a few legends it is not (no idea why)
            set(hChild(iChild),'TextColor',foreColor)
            % Set Edgecolor to foreColor
            set(hChild(iChild),'EdgeColor',foreColor)
        case 'surface'
            if ischar(get(hChild(iChild),'Facecolor'))
                % assume this means surface is a surf type plot, and leave
                % it alone
            else
                % assume in this case that surface is a mesh, and adjust
                % the facecolor to match background
                set(hChild(iChild),'FaceColor',backColor)
                % alpha adjustment here is a personal prefernce of mine
                set(hChild(iChild),'FaceAlpha',0.7)
            end
        case 'text'
            set(hChild(iChild),'Color',foreColor)
        case 'colorbar'
            set(hChild(iChild), 'color', foreColor)
        case 'heatmap'
            set(hChild(iChild), 'fontcolor', foreColor)
        case 'line'
            if invert
                if sum(get(hChild(iChild), 'color') == backColor) == 3
                    set(hChild(iChild), 'color', foreColor)
                end
            end
        case 'patch'
            if invert
                if isnumeric(get(hChild(iChild), 'facecolor'))
                    if sum(get(hChild(iChild), 'facecolor') == backColor) == 3
                        set(hChild(iChild), 'facecolor', foreColor)
                    end
                end
            end
        case 'errorbar'
            if invert
                if sum(get(hChild(iChild), 'color') == backColor) == 3
                    set(hChild(iChild), 'color', foreColor)
                end
            end
    end % switch typeChild

end % for 

end % recolorChildren

