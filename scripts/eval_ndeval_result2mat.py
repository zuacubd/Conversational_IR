"""This module does blah blah."""
import os
import sys

nd_evaluation_fields = [
    'ERR-IA@5',
    'ERR-IA@10',
    'ERR-IA@20',
    'nERR-IA@5',
    'nERR-IA@10',
    'nERR-IA@20',
    'alpha-DCG@5',
    'alpha-DCG@10',
    'alpha-DCG@20',
    'alpha-nDCG@5',
    'alpha-nDCG@10',
    'alpha-nDCG@20',
    'NRBP',
    'nNRBP',
    'MAP-IA',
    'P-IA@5',
    'P-IA@10',
    'P-IA@20',
    'strec@5',
    'strec@10',
    'strec@20'
]

def load_available_properties(root_path):
  """This function does blah blah."""
  # Initialising an empty set in order to store the properties names
  properties = set()
  # Going through all the run folders

  for current_path, _, files in os.walk(root_path):
    for filename in files:
    # Reconstructing the configuration file name
      if filename.endswith('.properties') or filename.endswith('.settings'):
        properties_filename = os.path.join(current_path, filename)
        # Checking if the configuration file exists
        if os.path.isfile(properties_filename):
          # Opening the configuration file for reading
          properties_file = open(properties_filename)
          # Going through the file lines
          for property_line in properties_file:
            # Removing leading and trailing whitespaces
            property_line = property_line.strip()
            # Checking if the line is valid
            if not property_line.startswith('#') and len(property_line) > 0:
              # Adding the configuration key to the parameters set
              property_name = property_line.split('=')[0].strip()
              available_properties.add(property_name)

  # Converting the parameter set to a list
  properties_as_list = list(properties)
  # Sorting the parameters names
  properties_as_list.sort()
  # Returing the sorted parameters list
  return properties_as_list


def print_matrix_row(queryid_evaluation_values):
    """This function does blah blah."""

    query_ids = queryid_evaluation_values.keys()
    sorted_query_ids = sorted(query_ids)

    for query_id in sorted_query_ids:

        #for property_name in available_properties:
        #
        #    property_name_alt = property_name.replace('bloc', 'block')
        #    print properties.get(property_name, properties.get(property_name_alt, 'none')) + '\t',
        #
        print (query_id, end='\t')
        evaluation_values = queryid_evaluation_values.get(query_id)

        for eval_value in evaluation_values:
            print (eval_value, end='\t')

        print ('')


def extract_trec_ndeval(evaluation_file):
    """ Function used the evaluation values of a nd_eval result file """

    queryid_evaluation_values = {}

    header = evaluation_file.readline()
    for line in evaluation_file:

        line_fields = line.rstrip().split(',')
        if line_fields[1] == 'amean':
            break

        query_id = line_fields[1]

        evaluation_values = []
        for f in range(2, len(line_fields)):
            evaluation_values.append(line_fields[f])

        queryid_evaluation_values[query_id] = evaluation_values

    return queryid_evaluation_values


def process_run(properties_filename):
  """ Function used to extract and print the matrixx lines for a given run
  (retrieved using the configuration file name)
  """
  # Extracting the properties contained in the current configuration file
  #properties = extract_terrier_properties(properties_filename)

  # Extraction of the configurane file name without its extension
  properties_filename_wo_extension, _ = os.path.splitext(properties_filename)
  #print (properties_filename_wo_extension)
  # Reconstructing the evaluation file name
  eval_filename = properties_filename_wo_extension + '.ndeval'
  #print (eval_filename)
  # Checking if the evaluation file exists for the current run
  if os.path.isfile(eval_filename):
    # Opening the evaluation file for reading
    eval_file = open(eval_filename)
    # Generating matrix rows from de run evaluation
    try:

        # Extracting the next matrix row
        queryid_evaluation_values = extract_trec_ndeval(eval_file)
        print_matrix_row(queryid_evaluation_values)

    except Exception as e:
      pass


def main():
  path = sys.argv[1]
  #available_properties = load_available_properties(path)
  # Printing the header
  #for a_property in available_properties:
  #  print a_property.replace('.', '_') + '\t',

  print ('requete', end='\t')
  for a_field in nd_evaluation_fields:
    print (a_field, end='\t')
  print ('')

  # Finding configuration files for each run
  #for current_path, _, files in os.walk(path):
  #  for filename in files:
  #    # Reconstructing the configuration file name
  #    if filename.endswith('.properties') or filename.endswith('.settings'):
  #      properties_filename = os.path.join(current_path, filename)
  #      # Checking if the configuration file exists
  #      if os.path.isfile(properties_filename):
  process_run(path)
  print ('')

main()
