# Introduction

MyAlertController was created to bring a easy form to custom an alert view for your app.

Here you find information about the classes and some usage examples.

### Features

* Smilar to Swift AlertController
* Some extra Items (TableView, CheckBox...)
* Easy to customize appearence
* Base Icon-Title-Message alert
* Support custom view controller
* Working on all screen sizes


# Installation

## Cocoapods
### Initiating pods in your project
If you don't initilized Cocoapods in your project, just open terminal and type the following:

```ruby
cd <YOUR-PROJECT-PATH>
pod init
```

This will create a file named **Podfile**.

### Installing this pod in your project
Open Podfile with a text editor and add the following:

```ruby
pod 'MyAlertController', :git => 'https://github.com/vitortexc/MyAlertController.git'
```

On terminal, do the following:

```ruby
cd <YOUR-PROJECT-PATH>
pod install
```

And you are done!


# Usage Example

This is a basic setup.

```swift
// Create the Alert with the parameters you want
let alert = MyAlert(title: "Adicionar uma pessoa", message: "Adicionando uma pessoa nos seus contatos", actionAlignment: .vertical)

// Add whatever wanted in your alert
alert.addTextField()
alert.addCheckBox("Não mostrar novamente esta mensagem.")

// Set the alert actions
// You can also pass an array of MyAlertActions with : addActions([actionOne, actionTwo])
alert.addAction(MyAlertAction(title: "Ok", dismissOnTap: true, action: { (action) in
  print(alert.checkedCheckBoxes)
}))
			
alert.addAction(MyAlertAction(title: "Cancel", dismissOnTap: true, action: { (action) in
  print("Alert dimissed")
}))

// Present it
self.present(alert, animated: true, completion: nil)
```
