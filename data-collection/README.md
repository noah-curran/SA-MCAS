# Data Collection
For the data collection, this directory includes some files for logging data
in [FlightGear](https://www.flightgear.org/download/). We also document below
how to set up data collection in FlightGear.

## Getting Started

### Where to Put Files
To get started, put `log-config.xml` into the directory of $FG_HOME. This directory
depends on the OS you are using. See below for the default location if you are
unsure of where $FG_HOME is defined.

**Windows**:
```
C:/Users/user/AppData/Roaming/flightgear.org
```

**Linux**:
```
/home/user/.fgfs
```

**MacOS**:
```
Unsure.
```

You will also need to have a plane that you wish to log the data of. There are some
planes packaged with FlightGear by default, but we will want to use other models as
well. Many custom models for popular aircraft can be found
[here](https://www.flightgear.org/download/download-aircraft/).

Once you have downloaded the desired models, you then must put them into the
FlightGear installation subfolder below.

**Windows**:
```
C:/Program Files/FlightGear/data/Aircraft
```

**Linux**:
```
Unsure.
```

**MacOS**:
```
Unsure.
```

### Launcher Settings
When launching FlightGear, you can either add these arguments to the `fgfs` command or
add them in the FlightGear Settings menu under *Additional Settings*.

```
--launcher
--config=$FG_HOME/log-config.xml
```

## Adding Additional Logs

### Finding New Sensors to Log
In order to log a sensor, you need to know its location in the property tree of
Flight Gear. In FlightGear, they use a tree for storing the state information
of a model, as it is a convenient way for them to keep track of the large number
of state variables. You can learn more about this property tree
[here](https://wiki.flightgear.org/Property_Tree/Explained). The property tree
can be searched by using the built in
[property browser](https://wiki.flightgear.org/Property_browser) of Flight Gear.
In order to access the property browser, you must launch FlightGear and start a
flight. Then, in the menu bar you go to `Debug > Browse Internal Properties`.
Here, you can search through the property browser to locate the sensors you need.

### Template for Adding New Sensor Logs
To add additional logs, use the following code block as a template:
```xml
<entry>
    <enabled>true</enabled>
    <title>Name of Sensor</title>
    <property>/property/browser/path/to/sensor</property>
</entry>
```
