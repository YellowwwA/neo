document.addEventListener("DOMContentLoaded", function () {
    const confirmBtn = document.getElementById("confirmBtn");

    confirmBtn.addEventListener("click", async function () {
        const year = document.getElementById("yearSelect").value;
        const region = document.getElementById("regionSelect").value;

        if (!year || !region) {
            alert("연도와 지역을 선택해주세요!");
            return;
        }

        try {
            const response = await axios.get(`http://192.168.1.40:3000/r_getkidsacc?year=${year}&region=${region}`);
            console.log(response.data);

            // 결과 표시
            const resultDiv = document.getElementById("result");
            if(response.data.resultcode == "success" && response.data.data.length > 0)
            {
                const data = response.data.data[0];
                resultDiv.innerHTML = `
                <h3>결과</h3>
                <p>년도: ${data.YEAR}</p>
                <p>지역: ${data.REGION}</p>
                <p>사고 건수: ${data.ACCIDENT_COUNT}</p>
                <p>부상자 수: ${data.INJURY_COUNT}</p>
                <p>사망자 수: ${data.DEATH_COUNT}</p>
            `;
            }

        } catch (error) {
            console.error("에러 발생:", error);
            alert("데이터를 불러오는 중 오류가 발생했습니다.");
        }
    });
});