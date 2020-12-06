classdef app2_exportedver4 < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                      matlab.ui.Figure
        PowerCalculationsLabel        matlab.ui.control.Label
        InputsLabel                   matlab.ui.control.Label
        outputsLabel                  matlab.ui.control.Label
        RectangualrFormLabel          matlab.ui.control.Label
        V_realjV_imagLabel            matlab.ui.control.Label
        VoltageEditFieldLabel         matlab.ui.control.Label
        V_real                        matlab.ui.control.NumericEditField
        jEditField_2Label             matlab.ui.control.Label
        V_imag                        matlab.ui.control.NumericEditField
        I_realjI_imagLabel            matlab.ui.control.Label
        CurrentEditFieldLabel         matlab.ui.control.Label
        I_real                        matlab.ui.control.NumericEditField
        jEditField_3Label             matlab.ui.control.Label
        I_imag                        matlab.ui.control.NumericEditField
        PolarFormLabel                matlab.ui.control.Label
        V_phasethetaLabel             matlab.ui.control.Label
        VoltageEditField_2Label       matlab.ui.control.Label
        V_phase                       matlab.ui.control.NumericEditField
        EditField_2Label              matlab.ui.control.Label
        V_theta                       matlab.ui.control.NumericEditField
        PjQLabel                      matlab.ui.control.Label
        ComplexpowerEditField_3Label  matlab.ui.control.Label
        P                             matlab.ui.control.NumericEditField
        jEditField_4Label             matlab.ui.control.Label
        Q                             matlab.ui.control.NumericEditField
        CalculateButton               matlab.ui.control.Button
        I_phasethetaLabel             matlab.ui.control.Label
        CurrentEditField_2Label       matlab.ui.control.Label
        I_phase                       matlab.ui.control.NumericEditField
        EditField_3Label              matlab.ui.control.Label
        I_theta                       matlab.ui.control.NumericEditField
        PthetaLabel                   matlab.ui.control.Label
        ComplexpowerEditField_2Label  matlab.ui.control.Label
        S_phase                       matlab.ui.control.NumericEditField
        EditFieldLabel                matlab.ui.control.Label
        S_theta                       matlab.ui.control.NumericEditField
        PowerFactorEditFieldLabel     matlab.ui.control.Label
        PF                            matlab.ui.control.EditField
        LoadImpedanceEditFieldLabel   matlab.ui.control.Label
        Zph_theta                     matlab.ui.control.EditField
        LeadLag                       matlab.ui.control.EditField
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: CalculateButton
        function CalculateButtonPushed(app, event)
            %%%calculations
            if(app.V_real.Value>0)
             V_rec=app.V_real.Value+app.V_imag.Value*1i;
             I_rec=app.I_real.Value+app.I_imag.Value*1i;
             
             %S_complex=V_rec*I_rec;
             Angle_diff=angle(V_rec)-angle(I_rec);
             PowerFactor=cos(Angle_diff);
             Z_com=V_rec/I_rec;
 
            
            else
             Vr=app.V_phase.Value;     % mag
             Vtheta=app.V_theta.Value; % angle
             %% convert to rectangular
             Va=Vr*cosd(Vtheta);
             Vb= Vr*sind(Vtheta);
             
              V_polar=Va+Vb*1i;
              
              Ir=app.I_phase.Value;     % mag
              Itheta=app.I_theta.Value; % angle
              %% convert to rectangular
             Ia=Ir*cosd(Itheta);
             Ib= Ir*sind(Itheta);
             
              I_polar=Ia+Ib*1i;
         
             Angle_diff=Vtheta-Itheta;
             PowerFactor=cosd(Angle_diff);   % angle is  input in degrees
             
             Z_com=V_polar/I_polar;
            end
            
            
            
            
            %%%output displaying
            
            app.Zph_theta.Value=strcat(num2str(abs(Z_com)),"<",num2str(rad2deg(angle(Z_com))));
            app.PF.Value=num2str(PowerFactor);
            
            if(Angle_diff<0)
                %lag
                app.LeadLag.Value="Lag";
            else
                app.LeadLag.Value="Lead";%lead
            end
            
            
            
            
            
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 650 640];
            app.UIFigure.Name = 'UI Figure';

            % Create PowerCalculationsLabel
            app.PowerCalculationsLabel = uilabel(app.UIFigure);
            app.PowerCalculationsLabel.FontSize = 18;
            app.PowerCalculationsLabel.FontWeight = 'bold';
            app.PowerCalculationsLabel.Position = [235 608 172 22];
            app.PowerCalculationsLabel.Text = 'Power Calculations';

            % Create InputsLabel
            app.InputsLabel = uilabel(app.UIFigure);
            app.InputsLabel.FontSize = 16;
            app.InputsLabel.FontWeight = 'bold';
            app.InputsLabel.Position = [173 551 53 22];
            app.InputsLabel.Text = 'Inputs';

            % Create outputsLabel
            app.outputsLabel = uilabel(app.UIFigure);
            app.outputsLabel.FontSize = 14;
            app.outputsLabel.FontWeight = 'bold';
            app.outputsLabel.Position = [439 551 57 22];
            app.outputsLabel.Text = 'outputs';

            % Create PowerFactorEditFieldLabel
            app.PowerFactorEditFieldLabel = uilabel(app.UIFigure);
            app.PowerFactorEditFieldLabel.FontWeight = 'bold';
            app.PowerFactorEditFieldLabel.Position = [387 508 82 22];
            app.PowerFactorEditFieldLabel.Text = 'Power Factor';

            % Create PF
            app.PF = uieditfield(app.UIFigure, 'text');
            app.PF.FontWeight = 'bold';
            app.PF.Position = [484 508 64 22];

            % Create LoadImpedanceEditFieldLabel
            app.LoadImpedanceEditFieldLabel = uilabel(app.UIFigure);
            app.LoadImpedanceEditFieldLabel.FontWeight = 'bold';
            app.LoadImpedanceEditFieldLabel.Position = [387 453 100 22];
            app.LoadImpedanceEditFieldLabel.Text = 'Load Impedance';

            % Create Zph_theta
            app.Zph_theta = uieditfield(app.UIFigure, 'text');
            app.Zph_theta.FontWeight = 'bold';
            app.Zph_theta.Position = [502 453 100 22];

            % Create PthetaLabel
            app.PthetaLabel = uilabel(app.UIFigure);
            app.PthetaLabel.FontWeight = 'bold';
            app.PthetaLabel.Position = [124 72 200 22];
            app.PthetaLabel.Text = 'P                           <                  theta';

            % Create ComplexpowerEditField_2Label
            app.ComplexpowerEditField_2Label = uilabel(app.UIFigure);
            app.ComplexpowerEditField_2Label.FontWeight = 'bold';
            app.ComplexpowerEditField_2Label.Position = [17 51 98 22];
            app.ComplexpowerEditField_2Label.Text = 'Complex power ';

            % Create S_phase
            app.S_phase = uieditfield(app.UIFigure, 'numeric');
            app.S_phase.HorizontalAlignment = 'left';
            app.S_phase.FontWeight = 'bold';
            app.S_phase.Position = [130 51 81 22];

            % Create EditFieldLabel
            app.EditFieldLabel = uilabel(app.UIFigure);
            app.EditFieldLabel.FontWeight = 'bold';
            app.EditFieldLabel.Position = [221 51 25 22];
            app.EditFieldLabel.Text = '<';

            % Create S_theta
            app.S_theta = uieditfield(app.UIFigure, 'numeric');
            app.S_theta.HorizontalAlignment = 'left';
            app.S_theta.FontWeight = 'bold';
            app.S_theta.Position = [261 51 100 22];

            % Create RectangualrFormLabel
            app.RectangualrFormLabel = uilabel(app.UIFigure);
            app.RectangualrFormLabel.BackgroundColor = [0.8 0.8 0.8];
            app.RectangualrFormLabel.FontSize = 14;
            app.RectangualrFormLabel.FontWeight = 'bold';
            app.RectangualrFormLabel.Position = [49 511 312 22];
            app.RectangualrFormLabel.Text = 'Rectangualr Form';

            % Create V_realjV_imagLabel
            app.V_realjV_imagLabel = uilabel(app.UIFigure);
            app.V_realjV_imagLabel.FontWeight = 'bold';
            app.V_realjV_imagLabel.Position = [131 487 210 22];
            app.V_realjV_imagLabel.Text = 'V_real               +j         V_imag';

            % Create VoltageEditFieldLabel
            app.VoltageEditFieldLabel = uilabel(app.UIFigure);
            app.VoltageEditFieldLabel.FontWeight = 'bold';
            app.VoltageEditFieldLabel.Position = [58 453 48 22];
            app.VoltageEditFieldLabel.Text = 'Voltage';

            % Create V_real
            app.V_real = uieditfield(app.UIFigure, 'numeric');
            app.V_real.HorizontalAlignment = 'left';
            app.V_real.FontWeight = 'bold';
            app.V_real.Position = [121 453 81 22];

            % Create jEditField_2Label
            app.jEditField_2Label = uilabel(app.UIFigure);
            app.jEditField_2Label.Position = [201 453 25 22];
            app.jEditField_2Label.Text = '+j';

            % Create V_imag
            app.V_imag = uieditfield(app.UIFigure, 'numeric');
            app.V_imag.HorizontalAlignment = 'left';
            app.V_imag.Position = [241 453 120 22];

            % Create I_realjI_imagLabel
            app.I_realjI_imagLabel = uilabel(app.UIFigure);
            app.I_realjI_imagLabel.FontWeight = 'bold';
            app.I_realjI_imagLabel.Position = [135 406 210 22];
            app.I_realjI_imagLabel.Text = 'I_real                +j        I_imag';

            % Create CurrentEditFieldLabel
            app.CurrentEditFieldLabel = uilabel(app.UIFigure);
            app.CurrentEditFieldLabel.FontWeight = 'bold';
            app.CurrentEditFieldLabel.Position = [61 372 49 22];
            app.CurrentEditFieldLabel.Text = 'Current';

            % Create I_real
            app.I_real = uieditfield(app.UIFigure, 'numeric');
            app.I_real.HorizontalAlignment = 'left';
            app.I_real.FontWeight = 'bold';
            app.I_real.Position = [125 372 81 22];

            % Create jEditField_3Label
            app.jEditField_3Label = uilabel(app.UIFigure);
            app.jEditField_3Label.Position = [205 372 25 22];
            app.jEditField_3Label.Text = '+j';

            % Create I_imag
            app.I_imag = uieditfield(app.UIFigure, 'numeric');
            app.I_imag.HorizontalAlignment = 'left';
            app.I_imag.Position = [245 372 116 22];

            % Create PolarFormLabel
            app.PolarFormLabel = uilabel(app.UIFigure);
            app.PolarFormLabel.BackgroundColor = [0.8 0.8 0.8];
            app.PolarFormLabel.FontSize = 14;
            app.PolarFormLabel.FontWeight = 'bold';
            app.PolarFormLabel.Position = [41 237 320 22];
            app.PolarFormLabel.Text = 'Polar Form';

            % Create V_phasethetaLabel
            app.V_phasethetaLabel = uilabel(app.UIFigure);
            app.V_phasethetaLabel.FontWeight = 'bold';
            app.V_phasethetaLabel.Position = [119 204 215 22];
            app.V_phasethetaLabel.Text = 'V_phase                   <                  theta';

            % Create VoltageEditField_2Label
            app.VoltageEditField_2Label = uilabel(app.UIFigure);
            app.VoltageEditField_2Label.FontWeight = 'bold';
            app.VoltageEditField_2Label.Position = [62 183 48 22];
            app.VoltageEditField_2Label.Text = 'Voltage';

            % Create V_phase
            app.V_phase = uieditfield(app.UIFigure, 'numeric');
            app.V_phase.HorizontalAlignment = 'left';
            app.V_phase.FontWeight = 'bold';
            app.V_phase.Position = [125 183 81 22];

            % Create EditField_2Label
            app.EditField_2Label = uilabel(app.UIFigure);
            app.EditField_2Label.FontWeight = 'bold';
            app.EditField_2Label.Position = [216 183 25 22];
            app.EditField_2Label.Text = '<';

            % Create V_theta
            app.V_theta = uieditfield(app.UIFigure, 'numeric');
            app.V_theta.HorizontalAlignment = 'left';
            app.V_theta.FontWeight = 'bold';
            app.V_theta.Position = [256 183 105 22];

            % Create I_phasethetaLabel
            app.I_phasethetaLabel = uilabel(app.UIFigure);
            app.I_phasethetaLabel.FontWeight = 'bold';
            app.I_phasethetaLabel.Position = [125 144 220 22];
            app.I_phasethetaLabel.Text = 'I_phase                      <                  theta';

            % Create CurrentEditField_2Label
            app.CurrentEditField_2Label = uilabel(app.UIFigure);
            app.CurrentEditField_2Label.FontWeight = 'bold';
            app.CurrentEditField_2Label.Position = [65 123 49 22];
            app.CurrentEditField_2Label.Text = 'Current';

            % Create I_phase
            app.I_phase = uieditfield(app.UIFigure, 'numeric');
            app.I_phase.HorizontalAlignment = 'left';
            app.I_phase.FontWeight = 'bold';
            app.I_phase.Position = [129 123 81 22];

            % Create EditField_3Label
            app.EditField_3Label = uilabel(app.UIFigure);
            app.EditField_3Label.FontWeight = 'bold';
            app.EditField_3Label.Position = [221 123 25 22];
            app.EditField_3Label.Text = '<';

            % Create I_theta
            app.I_theta = uieditfield(app.UIFigure, 'numeric');
            app.I_theta.HorizontalAlignment = 'left';
            app.I_theta.FontWeight = 'bold';
            app.I_theta.Position = [261 123 100 22];

            % Create PjQLabel
            app.PjQLabel = uilabel(app.UIFigure);
            app.PjQLabel.FontWeight = 'bold';
            app.PjQLabel.Position = [155 322 210 22];
            app.PjQLabel.Text = 'P                       +j                    Q';

            % Create ComplexpowerEditField_3Label
            app.ComplexpowerEditField_3Label = uilabel(app.UIFigure);
            app.ComplexpowerEditField_3Label.FontWeight = 'bold';
            app.ComplexpowerEditField_3Label.Position = [41 288 98 22];
            app.ComplexpowerEditField_3Label.Text = 'Complex power ';

            % Create P
            app.P = uieditfield(app.UIFigure, 'numeric');
            app.P.HorizontalAlignment = 'left';
            app.P.FontWeight = 'bold';
            app.P.Position = [154 288 64 22];

            % Create jEditField_4Label
            app.jEditField_4Label = uilabel(app.UIFigure);
            app.jEditField_4Label.Position = [225 288 25 22];
            app.jEditField_4Label.Text = '+j';

            % Create Q
            app.Q = uieditfield(app.UIFigure, 'numeric');
            app.Q.HorizontalAlignment = 'left';
            app.Q.Position = [265 288 96 22];

            % Create CalculateButton
            app.CalculateButton = uibutton(app.UIFigure, 'push');
            app.CalculateButton.ButtonPushedFcn = createCallbackFcn(app, @CalculateButtonPushed, true);
            app.CalculateButton.BackgroundColor = [0.651 0.651 0.651];
            app.CalculateButton.FontSize = 18;
            app.CalculateButton.FontWeight = 'bold';
            app.CalculateButton.Position = [418 322 184 72];
            app.CalculateButton.Text = 'Calculate';

            % Create LeadLag
            app.LeadLag = uieditfield(app.UIFigure, 'text');
            app.LeadLag.Position = [557 508 45 22];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = app2_exportedver4

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