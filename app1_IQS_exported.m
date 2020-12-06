classdef app1_IQS_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                      matlab.ui.Figure
        PowercalculationsLabel        matlab.ui.control.Label
        PhaseVoltageEditFieldLabel    matlab.ui.control.Label
        V_real                        matlab.ui.control.NumericEditField
        PFEditFieldLabel              matlab.ui.control.Label
        PowerFactor                   matlab.ui.control.NumericEditField
        RealPowerEditFieldLabel       matlab.ui.control.Label
        Real_power                    matlab.ui.control.NumericEditField
        InputsLabel                   matlab.ui.control.Label
        OutputsLabel                  matlab.ui.control.Label
        PhaseCurrentEditFieldLabel    matlab.ui.control.Label
        I_phase                       matlab.ui.control.EditField
        ReactivePowerEditFieldLabel   matlab.ui.control.Label
        Reactive_power                matlab.ui.control.EditField
        ComplexPowerEditFieldLabel    matlab.ui.control.Label
        Complex_power                 matlab.ui.control.EditField
        JEditFieldLabel               matlab.ui.control.Label
        PhaseVoltageEditField_2Label  matlab.ui.control.Label
        V_phase                       matlab.ui.control.NumericEditField
        JEditFieldLabel_2             matlab.ui.control.Label
        V_angle                       matlab.ui.control.NumericEditField
        ORLabel                       matlab.ui.control.Label
        CalculateButton               matlab.ui.control.Button
        V_imag                        matlab.ui.control.NumericEditField
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: CalculateButton
        function CalculateButtonPushed(app, event)
            
            %calculations
            
            if(app.V_real.Value>0)
                voltage=app.V_real.Value+app.V_imag.Value*1i;
                
                
            else
                voltage=app.V_phase.Value * cosd(app.V_angle.Value)+app.V_phase.Value * sind(app.V_angle.Value);
                
            end
            P=app.Real_power.Value;
            PF=app.PowerFactor.Value;
            
            theta=acosd(PF);
            Q=P*tand(theta);
            S=P+Q*1i;

            
            I=S/voltage;
            
            %displaying
            app.I_phase.Value=strcat(num2str(abs(I)),"<",num2str(angle(I)));
            app.Reactive_power.Value=num2str(Q);
            app.Complex_power.Value=strcat( num2str(abs(S)), '<', num2str(angle(S)));
            
            
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'UI Figure';

            % Create PowercalculationsLabel
            app.PowercalculationsLabel = uilabel(app.UIFigure);
            app.PowercalculationsLabel.FontSize = 18;
            app.PowercalculationsLabel.FontWeight = 'bold';
            app.PowercalculationsLabel.Position = [237 434 169 22];
            app.PowercalculationsLabel.Text = 'Power calculations';

            % Create PhaseVoltageEditFieldLabel
            app.PhaseVoltageEditFieldLabel = uilabel(app.UIFigure);
            app.PhaseVoltageEditFieldLabel.FontWeight = 'bold';
            app.PhaseVoltageEditFieldLabel.Position = [30 273 87 22];
            app.PhaseVoltageEditFieldLabel.Text = 'Phase Voltage';

            % Create V_real
            app.V_real = uieditfield(app.UIFigure, 'numeric');
            app.V_real.HorizontalAlignment = 'left';
            app.V_real.FontWeight = 'bold';
            app.V_real.Position = [132 273 57 22];

            % Create PFEditFieldLabel
            app.PFEditFieldLabel = uilabel(app.UIFigure);
            app.PFEditFieldLabel.FontWeight = 'bold';
            app.PFEditFieldLabel.Position = [43 90 57 22];
            app.PFEditFieldLabel.Text = 'PF';

            % Create PowerFactor
            app.PowerFactor = uieditfield(app.UIFigure, 'numeric');
            app.PowerFactor.HorizontalAlignment = 'left';
            app.PowerFactor.FontWeight = 'bold';
            app.PowerFactor.Position = [115 90 160 22];

            % Create RealPowerEditFieldLabel
            app.RealPowerEditFieldLabel = uilabel(app.UIFigure);
            app.RealPowerEditFieldLabel.FontWeight = 'bold';
            app.RealPowerEditFieldLabel.Position = [30 145 70 22];
            app.RealPowerEditFieldLabel.Text = 'Real Power';

            % Create Real_power
            app.Real_power = uieditfield(app.UIFigure, 'numeric');
            app.Real_power.HorizontalAlignment = 'left';
            app.Real_power.FontWeight = 'bold';
            app.Real_power.Position = [115 145 160 22];

            % Create InputsLabel
            app.InputsLabel = uilabel(app.UIFigure);
            app.InputsLabel.FontSize = 14;
            app.InputsLabel.FontWeight = 'bold';
            app.InputsLabel.Position = [86 359 47 22];
            app.InputsLabel.Text = 'Inputs';

            % Create OutputsLabel
            app.OutputsLabel = uilabel(app.UIFigure);
            app.OutputsLabel.FontSize = 14;
            app.OutputsLabel.FontWeight = 'bold';
            app.OutputsLabel.Position = [487 359 59 22];
            app.OutputsLabel.Text = 'Outputs';

            % Create PhaseCurrentEditFieldLabel
            app.PhaseCurrentEditFieldLabel = uilabel(app.UIFigure);
            app.PhaseCurrentEditFieldLabel.HorizontalAlignment = 'right';
            app.PhaseCurrentEditFieldLabel.FontWeight = 'bold';
            app.PhaseCurrentEditFieldLabel.Position = [400 273 88 22];
            app.PhaseCurrentEditFieldLabel.Text = 'Phase Current';

            % Create I_phase
            app.I_phase = uieditfield(app.UIFigure, 'text');
            app.I_phase.FontWeight = 'bold';
            app.I_phase.Position = [503 273 100 22];

            % Create ReactivePowerEditFieldLabel
            app.ReactivePowerEditFieldLabel = uilabel(app.UIFigure);
            app.ReactivePowerEditFieldLabel.HorizontalAlignment = 'right';
            app.ReactivePowerEditFieldLabel.FontWeight = 'bold';
            app.ReactivePowerEditFieldLabel.Position = [394 221 94 22];
            app.ReactivePowerEditFieldLabel.Text = 'Reactive Power';

            % Create Reactive_power
            app.Reactive_power = uieditfield(app.UIFigure, 'text');
            app.Reactive_power.FontWeight = 'bold';
            app.Reactive_power.Position = [503 221 100 22];

            % Create ComplexPowerEditFieldLabel
            app.ComplexPowerEditFieldLabel = uilabel(app.UIFigure);
            app.ComplexPowerEditFieldLabel.HorizontalAlignment = 'right';
            app.ComplexPowerEditFieldLabel.FontWeight = 'bold';
            app.ComplexPowerEditFieldLabel.Position = [392 166 96 22];
            app.ComplexPowerEditFieldLabel.Text = 'Complex Power';

            % Create Complex_power
            app.Complex_power = uieditfield(app.UIFigure, 'text');
            app.Complex_power.FontWeight = 'bold';
            app.Complex_power.Position = [503 166 100 22];

            % Create JEditFieldLabel
            app.JEditFieldLabel = uilabel(app.UIFigure);
            app.JEditFieldLabel.FontWeight = 'bold';
            app.JEditFieldLabel.Position = [199 273 25 22];
            app.JEditFieldLabel.Text = '+J';

            % Create V_imag
            app.V_imag = uieditfield(app.UIFigure, 'numeric');
            app.V_imag.HorizontalAlignment = 'left';
            app.V_imag.FontWeight = 'bold';
            app.V_imag.Position = [223 273 52 22];

            % Create PhaseVoltageEditField_2Label
            app.PhaseVoltageEditField_2Label = uilabel(app.UIFigure);
            app.PhaseVoltageEditField_2Label.FontWeight = 'bold';
            app.PhaseVoltageEditField_2Label.Position = [21 200 87 22];
            app.PhaseVoltageEditField_2Label.Text = 'Phase Voltage';

            % Create V_phase
            app.V_phase = uieditfield(app.UIFigure, 'numeric');
            app.V_phase.HorizontalAlignment = 'left';
            app.V_phase.FontWeight = 'bold';
            app.V_phase.Position = [123 200 57 22];

            % Create JEditFieldLabel_2
            app.JEditFieldLabel_2 = uilabel(app.UIFigure);
            app.JEditFieldLabel_2.FontWeight = 'bold';
            app.JEditFieldLabel_2.Position = [200 200 25 22];
            app.JEditFieldLabel_2.Text = '<';

            % Create V_angle
            app.V_angle = uieditfield(app.UIFigure, 'numeric');
            app.V_angle.HorizontalAlignment = 'left';
            app.V_angle.FontWeight = 'bold';
            app.V_angle.Position = [224 200 52 22];

            % Create ORLabel
            app.ORLabel = uilabel(app.UIFigure);
            app.ORLabel.FontWeight = 'bold';
            app.ORLabel.Position = [136 242 25 22];
            app.ORLabel.Text = 'OR';

            % Create CalculateButton
            app.CalculateButton = uibutton(app.UIFigure, 'push');
            app.CalculateButton.ButtonPushedFcn = createCallbackFcn(app, @CalculateButtonPushed, true);
            app.CalculateButton.BackgroundColor = [0.651 0.651 0.651];
            app.CalculateButton.FontSize = 16;
            app.CalculateButton.FontWeight = 'bold';
            app.CalculateButton.Position = [395 80 208 53];
            app.CalculateButton.Text = 'Calculate';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = app1_IQS_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end