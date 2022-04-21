import serial

class MorseDecoderLibrary(object):
    ''' Library for interacting with morse sender and decoder
    '''
    ROBOT_LIBRARY_SCOPE = 'SUITE' 
    
    def __init__(self, port1, port2):
        
        self._sender = serial.Serial(port1, 115200, timeout = 1)
        self._decoder = serial.Serial(port2, 115200, timeout = 20)


    def set_speed(self, speed):
        self._sender.write(bytes('wpm ' + speed + '\n', 'utf-8'))


    def send_text(self, text):
        self._decoder.reset_input_buffer()
        self._sender.write(bytes("text " + text + '\n', 'utf-8'))


    def speed_should_be(self, expected_speed):
        text = self._decoder.readline().strip().decode('utf-8')
        speed = int(text.split()[2])
        if speed != int(expected_speed):
            raise AssertionError('Expected: ' + str(expected_speed) + ' got: '  + str(speed) + ' line: ' + text)


    def text_should_be(self, expected_text):
        text = self._decoder.readline().strip().decode('utf-8')
        if text != expected_text:
            raise AssertionError('Expected: ' + expected_text + ' got: ' + text)
        

    def disable(self):
        self._decoder.readline()


    def enable(self):
        self._decoder.readline()


    def verify_speed(self, speed):
        self._decoder.write(bytes('\nwpm\n', 'utf-8'))
        actual_speed = self._decoder.readline()
        if speed != int(actual_speed):
            raise AssertionError('Expected: ' + str(actual_speed) + ' got: '  + str(speed))