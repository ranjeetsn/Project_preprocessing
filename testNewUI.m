classdef testNewUI < matlab.uitest.TestCase
    
    properties
        File = 'C:\Users\Ranjeet Nagarkar\Desktop\Project\Code\dynamic_test_case.mat';
    end
    methods(Test)
        function DynamicTestingCase1(testCase, this)
            app = newUI;
            %testCase.addTeardown(@delete,app);
            this.app.LoadDataDropdown
            %testCase.choose('Data File')
            
            
        end
    end
    
    
end