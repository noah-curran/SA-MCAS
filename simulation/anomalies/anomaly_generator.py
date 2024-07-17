import argparse
import numpy as np

def main(args):
    L = ["This is Delhi \n", "This is Paris \n", "This is London \n"]
  
    filepath = ''

    if args.anomtype == 'sudden':
        if args.injection == None:
            return
        
        filepath = './' + args.anomtype + '_of_' + str(args.injection) + '_during_' + str(args.starttime) + \
                '_to_' + str(args.endtime) + '_on_' + str(args.sensor)

        json = [
                '{\n',
                    '\t"Injection": {\n',
                        '\t\t"InjectionType": 1,\n',
                        '\t\t"StartTime": ' + str(args.starttime) + ',\n',
                        '\t\t"EndTime": ' + str(args.endtime) + ',\n',
                        '\t\t"Val": ' + str(args.injection) + ',\n',
                        '\t\t"Sensor Index": ' + str(args.sensor) + ',\n',
                        '\t\t"Type": 0,\n',
                        '\t\t"Coef1": 0,\n',
                        '\t\t"Coef2": 0,\n',
                        '\t\t"Freq": 0,\n',
                        '\t\t"Percentile": 0\n',
                    '\t}\n',
                '}\n'
        ]

    elif args.anomtype == 'delta':
        if args.injection == None:
            return

        filepath = './' + args.anomtype + '_of_' + str(args.injection) + '_during_' + str(args.starttime) + \
                '_to_' + str(args.endtime) + '_on_' + str(args.sensor)

        json = [
                '{\n',
                    '\t"Injection": {\n',
                        '\t\t"InjectionType": 2,\n',
                        '\t\t"StartTime": ' + str(args.starttime) + ',\n',
                        '\t\t"EndTime": ' + str(args.endtime) + ',\n',
                        '\t\t"Val": ' + str(args.injection) + ',\n',
                        '\t\t"Sensor Index": ' + str(args.sensor) + ',\n',
                        '\t\t"Type": 0,\n',
                        '\t\t"Coef1": 0,\n',
                        '\t\t"Coef2": 0,\n',
                        '\t\t"Freq": 0,\n',
                        '\t\t"Percentile": 0\n',
                    '\t}\n',
                '}\n'
        ]

    elif args.anomtype == 'gradual':
        if args.type == None or args.coef1 == None or args.coef2 == None or args.freq == None:
            return
        filepath = './' + args.anomtype + '_of_' + args.type + '_' + str(args.coef1) + '_' + \
                str(args.coef2) + '_' + str(args.freq) + '_during_' + str(args.starttime) + '_to_' + \
                str(args.endtime) + '_on_' + str(args.sensor)
    
        if args.type.lower() == 'lin' or args.type.lower() == 'linear':
            args.type = 1
        elif args.type.lower() == 'quad' or args.type.lower() == 'quadratic':
            args.type = 2
        elif args.type.lower() == 'log' or args.type.lower() == 'logarithmic':
            args.type = 3

        json = [
                '{\n',
                    '\t"Injection": {\n',
                        '\t\t"InjectionType": 3,\n',
                        '\t\t"StartTime": ' + str(args.starttime) + ',\n',
                        '\t\t"EndTime": ' + str(args.endtime) + ',\n',
                        '\t\t"Val": 0,\n',
                        '\t\t"Sensor Index": ' + str(args.sensor) + ',\n',
                        '\t\t"Type": ' + str(args.type) + ',\n',
                        '\t\t"Coef1": ' + str(args.coef1) + ',\n',
                        '\t\t"Coef2": ' + str(args.coef2) + ',\n',
                        '\t\t"Freq": ' + str(args.freq) + ',\n',
                        '\t\t"Percentile": 0\n',
                    '\t}\n',
                '}\n'
        ]

    filepath += '.json'

    # Writing to file
    with open(filepath, "w") as fp:
        # Writing data to a file
        fp.writelines(json)

def parse_arguments():
    """Read arguments from a command line."""
    parser = argparse.ArgumentParser(description='Arguments get parsed via --commands')
    parser.add_argument('anomtype', action='store', choices=['sudden', 'delta', 'gradual'],
        help='The anomaly type to generate.')
    parser.add_argument('starttime', action='store', type=float,
        help='The start time of the anomaly.')
    parser.add_argument('endtime', action='store', type=float,
        help='The end time of the anomaly.')
    parser.add_argument('sensor', action='store', type=int,
        help='The sensor index to inject.')
    parser.add_argument('-i', '--injection-val', action='store', type=float, dest='injection',
        required=False, help='The injection value for a sudden or delta injection.')
    parser.add_argument('-t', '--grad-type', action='store', choices=['linear', 'lin', 'quadratic',
        'quad', 'logarithmic', 'log'], dest='type', required=False,
        help='The injection type for a gradual injection.')
    parser.add_argument('-a', '--a-coef', action='store', type=float, dest='coef1', required=False,
        help='The first coefficient for a gradual injection.')
    parser.add_argument('-b', '--b-coef', action='store', type=float, dest='coef2', required=False,
        help='The second coefficient for a gradual injection.')
    parser.add_argument('-f', '--freq', action='store', type=float, dest='freq', required=False,
        help='The frequency for a gradual injection recovery.')

    args = parser.parse_args()
    
    return args


if __name__ == "__main__":
    main(parse_arguments())