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

## Editing the Log Configuration
There are a few parameters of `log-config.xml` that can be changed according to personal
needs.

### `<filename>`
The filename parameter is simply where the log file is saved to. This can be anywhere on
your machine, but the recommended location is in the `Export` folder. The actual name of
the file can also be anything you want. For instance, if you are performing a specific
flight routine and wish to log for it, then you may name the log file to reflect that
routine. Due to an undocumented bug that occurs due to a prior patch for a vulnerability,
absolute path names are the only way to define a destination to the log file.

### `<enabled>`
This parameter allows for us to enable and disable certain logged sensor values as we
go along. This may be useful if there are some sensors for which we wish to include, but
are not currently seeking to measure.

### `<interval-ms>`
Here we define the rate at which the logger collects more sensor data, measure in
milliseconds. This rate should be artificially high and we can adjust the downsample as 
necessary in the post processing. Ideally, this rate should be as fast as the fastest
sensor that way we do not have to interpolate for fine-grained readings.

### `<delimiter>`
In order to save to a .csv file, this should remain as a `,`.
