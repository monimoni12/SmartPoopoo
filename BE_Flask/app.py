from flask import Flask, request, jsonify

app = Flask(__name__)

# 다이어리 데이터 저장을 위한 임시 저장소 (메모리 저장)
diary_entries = []

@app.route('/diary', methods=['POST'])
def add_diary_entry():
    data = request.json
    diary_text = data.get('text', '')
    if diary_text:
        # 새로운 다이어리 항목 추가
        diary_entries.append(diary_text)
        return jsonify({'message': '다이어리 저장 성공', 'data': diary_entries}), 201
    else:
        return jsonify({'message': '텍스트 내용이 필요합니다.'}), 400

@app.route('/diary', methods=['GET'])
def get_diary_entries():
    # 저장된 모든 다이어리 항목 반환
    return jsonify({'entries': diary_entries}), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
