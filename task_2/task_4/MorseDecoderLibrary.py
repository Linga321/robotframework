import serial

class MorseDecoderLibrary(object):
    ''' Library for interacting with morse sender and decoder
    '''

    ROBOT_LIBRARY_SCOPE = 'GLOBAL' 

    def __init__(self, portsender, portdecoder):
        self._sender = serial.Serial(str(portsender), 115200, timeout = 1)
        self._decoder = serial.Serial(str(portdecoder), 115200, timeout = 20)


    def set_speed(self, speed):
        self._sender.write(bytes('\nwpm ' + speed + '\n', 'utf-8'))
        self._decoder.reset_input_buffer()

    def send_text(self, text):
        self._decoder.reset_input_buffer()
        self._sender.write(bytes("\ntext " + text + '\n', 'utf-8'))


    def speed_should_be(self, expected_speed):
        text = self._decoder.readline().strip().decode('utf-8')
        speed = int(text.split()[2])
        if speed != int(expected_speed):
            raise AssertionError('Expected: ' + str(expected_speed) + ' got: '  + str(speed) + ' line: ' + text)


    def text_should_be(self, expected_text):
        text = self._decoder.readline().strip().decode('utf-8')
        if text != expected_text:
            raise AssertionError('Expected: ' + expected_text + ' got: ' + text)
        

    def wpm_state(self, state):
        self._decoder.write(bytes("\nwpm " + state + '\n', 'utf-8'))
        self._decoder.readline()
    

    def imm_state(self, state):
        self._decoder.write(bytes("\nimm " + state + '\n', 'utf-8'))
        self._decoder.readline()


    def check_speed(self, expected_speed):
        self._decoder.write(bytes('\nwpm\n', 'utf-8'))
        text = self._decoder.readline().strip().decode('utf-8')
        speed = int(text.split()[2])
        if speed != int(expected_speed):
            raise AssertionError('Expected: ' + str(expected_speed) + ' got: '  + str(speed) + ' line: ' + text)


    def roundup_speed(self, relaxed_speed , tolerance):
        self._decoder.write(bytes('\nwpm\n', 'utf-8'))
        text = self._decoder.readline().strip().decode('utf-8')
        speed = int(text.split()[2])
        percentage = int(tolerance)*(int(relaxed_speed)/100)
        relaxed_speed = int(relaxed_speed)
        min = relaxed_speed - percentage
        max = relaxed_speed + percentage
        if (min > speed  or max < speed):
            raise AssertionError('Expected:' + str(relaxed_speed) + ' got: '  + str(speed) + ' line: ' + text)