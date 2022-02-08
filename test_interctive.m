fig = uifigure;
lamp = uilamp(fig,'Position',[50 100 20 20],'Color','red');
button = uibutton(fig,'ButtonPushedFcn',@(btn,event) set(lamp,'Color','green'));
tc = matlab.uitest.TestCase.forInteractiveUse;
tc.press(button)
tc.verifyEqual(lamp.Color,'green')
tc.verifyEqual(lamp.Color,[0 1 0])