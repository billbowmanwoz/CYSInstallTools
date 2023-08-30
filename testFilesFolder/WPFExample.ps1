Add-Type -TypeDefinition @'
using System;
using System.Windows;
using System.Windows.Controls;

public class MyWindow : Window
{
    public MyWindow()
    {
        Title = "PowerShell WPF GUI";
        Width = 400;
        Height = 300;

        Label label = new Label();
        label.Content = "Hello, PowerShell WPF GUI!";
        label.Margin = new Thickness(100, 50, 0, 0);
        
        Button button = new Button();
        button.Content = "Click Me";
        button.Margin = new Thickness(150, 100, 0, 0);
        button.Click += Button_Click;

        Content = new StackPanel();
        ((StackPanel)Content).Children.Add(label);
        ((StackPanel)Content).Children.Add(button);
    }

    private void Button_Click(object sender, RoutedEventArgs e)
    {
        ((Label)((StackPanel)Content).Children[0]).Content = "Button Clicked!";
    }
}
'@

$window = New-Object MyWindow
$window.ShowDialog() | Out-Null
